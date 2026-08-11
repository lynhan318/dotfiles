--!nonstrict
-- Displays — list, configure and reorder niri outputs.
--
-- Live state comes from `niri msg -j outputs`. noctalia.outputs() is not enough
-- here: it gives geometry and scale but no mode list and no refresh rate, and
-- refresh rate is half the point of this panel.
--
-- Every change is applied immediately with `niri msg output ...` and then
-- written to a generated KDL file. niri's own help is explicit that IPC output
-- changes are temporary — "If the output configuration subsequently changes in
-- the config file, these temporary changes will be forgotten" — so without the
-- file half of this panel would quietly undo itself on the next config reload.

local NIRI = "niri"

--- runAsync's argv-table form needs plugin_api >= 24; the string form runs
--- through /bin/sh -c and works on every host, so commands are assembled by
--- hand. Single-quoted with the '"'"' escape, because an output key can be a
--- make/model/serial description with spaces in it.
local function quote(value)
  return "'" .. string.gsub(tostring(value), "'", "'\\''") .. "'"
end

local function niriCmd(...)
  local parts = { NIRI, "msg" }
  for _, arg in ipairs({ ... }) do
    parts[#parts + 1] = quote(arg)
  end
  return table.concat(parts, " ")
end

local outputs = {} -- ordered left-to-right by x, as drawn
local selected = nil -- connector name
local status = ""
local busy = false

-- getConfig reads one key at a time; there is no "give me the whole table" form.
local function config()
  local path = noctalia.getConfig("generated_config")
  if type(path) ~= "string" or path == "" then
    path = "~/.config/niri/displays-generated.kdl"
  end
  return {
    path = noctalia.expandPath(path),
    persist = noctalia.getConfig("persist") ~= false,
  }
end

-- ── model ───────────────────────────────────────────────────────────────────

local function modeKey(mode)
  return string.format("%dx%d@%.3f", mode.width, mode.height, mode.refresh_rate / 1000)
end

local function modeLabel(mode)
  local label = string.format("%d × %d @ %.2f Hz", mode.width, mode.height, mode.refresh_rate / 1000)
  if mode.is_preferred then
    label ..= "  (preferred)"
  end
  return label
end

local function currentMode(output)
  if output.current_mode == nil then
    return nil
  end
  -- niri reports current_mode as an index into modes.
  return output.modes[output.current_mode + 1]
end

--- Resolutions, deduped, keeping the highest refresh per size for the label.
local function resolutions(output)
  local seen, list = {}, {}
  for _, mode in ipairs(output.modes or {}) do
    local key = string.format("%dx%d", mode.width, mode.height)
    if seen[key] == nil then
      seen[key] = true
      list[#list + 1] = { key = key, width = mode.width, height = mode.height }
    end
  end
  return list
end

--- Refresh rates available at the output's current resolution. This is what
--- makes the 60/120 Hz switch on the laptop panel work without hardcoding
--- either number, or the eDP-1 connector name.
local function refreshRates(output)
  local mode = currentMode(output)
  if mode == nil then
    return {}
  end
  local list = {}
  for _, candidate in ipairs(output.modes or {}) do
    if candidate.width == mode.width and candidate.height == mode.height then
      list[#list + 1] = candidate
    end
  end
  table.sort(list, function(a, b)
    return a.refresh_rate < b.refresh_rate
  end)
  return list
end

local function indexOf(list, predicate)
  for i, item in ipairs(list) do
    if predicate(item) then
      return i - 1 -- ui.select is 0-based
    end
  end
  return 0
end

local function find(name)
  for _, output in ipairs(outputs) do
    if output.name == name then
      return output
    end
  end
  return nil
end

--- Read the arrangement back out of the geometry rather than storing it: the
--- positions are the truth, and they can be changed from the niri config or
--- another tool between two openings of this panel. Displays sharing one x are
--- stacked; anything else is treated as side by side.
function arrangement()
  if #outputs < 2 then
    return "horizontal"
  end
  local firstX = outputs[1].logical ~= nil and outputs[1].logical.x or 0
  for _, output in ipairs(outputs) do
    local x = output.logical ~= nil and output.logical.x or 0
    if x ~= firstX then
      return "horizontal"
    end
  end
  return "vertical"
end

-- ── niri IPC ────────────────────────────────────────────────────────────────

local function refresh(onDone)
  noctalia.runAsync(niriCmd("-j", "outputs"), function(result)
    if result.exitCode ~= 0 then
      status = "niri is not answering: " .. (result.stderr ~= "" and result.stderr or "exit " .. result.exitCode)
      outputs = {}
      render()
      return
    end

    local decoded, err = noctalia.json.decode(result.stdout)
    if decoded == nil then
      status = "could not parse niri output: " .. tostring(err)
      render()
      return
    end

    outputs = {}
    for connector, output in pairs(decoded) do
      output.name = connector
      outputs[#outputs + 1] = output
    end
    -- Sorted along whichever axis the displays are arranged on, so the tiles
    -- read in the same order as the screens: left-to-right, or top-to-bottom
    -- when stacked.
    local stacked = #outputs > 1
    local firstX = outputs[1] ~= nil and outputs[1].logical ~= nil and outputs[1].logical.x or 0
    for _, output in ipairs(outputs) do
      if (output.logical ~= nil and output.logical.x or 0) ~= firstX then
        stacked = false
        break
      end
    end

    table.sort(outputs, function(a, b)
      local al = a.logical or { x = 0, y = 0 }
      local bl = b.logical or { x = 0, y = 0 }
      local primaryA = stacked and (al.y or 0) or (al.x or 0)
      local primaryB = stacked and (bl.y or 0) or (bl.x or 0)
      if primaryA == primaryB then
        return a.name < b.name
      end
      return primaryA < primaryB
    end)

    if selected == nil or find(selected) == nil then
      selected = outputs[1] ~= nil and outputs[1].name or nil
    end

    if onDone ~= nil then
      onDone()
    else
      render()
    end
  end, 5000)
end

--- Run a niri output action, then re-read the real state rather than trusting
--- the request: niri clamps and rejects, and the panel should show what
--- actually happened.
local function apply(argv, description)
  busy = true
  status = description .. "…"
  render()

  local args = { "output" }
  for _, part in ipairs(argv) do
    args[#args + 1] = part
  end

  noctalia.runAsync(niriCmd(table.unpack(args)), function(result)
    busy = false
    if result.exitCode ~= 0 then
      status = "failed: " .. (result.stderr ~= "" and result.stderr or "exit " .. result.exitCode)
      noctalia.notifyError("Displays", status)
      render()
      return
    end
    refresh(function()
      persist()
      status = description
      render()
    end)
  end, 8000)
end

-- ── persistence ─────────────────────────────────────────────────────────────

--- niri matches an output block by connector *or* by its make/model/serial
--- description. Writing the description means a monitor keeps its settings when
--- a dock or a different USB-C port renames the connector.
local function outputKey(output)
  local make = output.make or ""
  local model = output.model or ""
  local serial = output.serial or ""
  if make ~= "" and model ~= "" and serial ~= "" then
    return string.format("%s %s %s", make, model, serial)
  end
  return output.name
end

function persist()
  local cfg = config()
  if not cfg.persist then
    return
  end

  local lines = {
    "// Generated by the Noctalia \"displays\" plugin — do not edit.",
    "// Rewritten whenever a display is changed from the Displays panel.",
    "//",
    "// Outputs are keyed by make/model/serial where the monitor reports one, so a",
    "// dock handing it a different connector does not lose these settings.",
    "",
  }

  for _, output in ipairs(outputs) do
    local mode = currentMode(output)
    lines[#lines + 1] = string.format('output %q {', outputKey(output))
    if mode ~= nil then
      lines[#lines + 1] = string.format("    mode %q", modeKey(mode))
    end
    if output.logical ~= nil then
      lines[#lines + 1] = string.format("    scale %s", tostring(output.logical.scale))
      lines[#lines + 1] = string.format("    position x=%d y=%d", output.logical.x, output.logical.y)
      -- niri reports the transform capitalised ("Normal", "_90") but only
      -- accepts it lowercase in the config.
      local transform = string.lower(output.logical.transform or "normal")
      transform = string.gsub(transform, "^_", "")
      if transform ~= "normal" then
        lines[#lines + 1] = string.format("    transform %q", transform)
      end
    end
    lines[#lines + 1] = "}"
    lines[#lines + 1] = ""
  end

  local ok, err = noctalia.writeFile(cfg.path, table.concat(lines, "\n"))
  if not ok then
    noctalia.notifyError("Displays", "could not write " .. cfg.path .. ": " .. tostring(err))
  end
end

-- ── actions ─────────────────────────────────────────────────────────────────

function onSelect(name)
  selected = name
  render()
end

function onResolutionChange(index, label)
  local output = find(selected)
  if output == nil then
    return
  end
  local choice = resolutions(output)[tonumber(index) + 1]
  if choice == nil then
    return
  end
  -- Keep the closest refresh rate available at the new size instead of
  -- dropping to whatever niri picks: switching resolution should not silently
  -- cost you 120 Hz.
  local mode = currentMode(output)
  local wanted = mode ~= nil and mode.refresh_rate or 0
  local best = nil
  for _, candidate in ipairs(output.modes or {}) do
    if candidate.width == choice.width and candidate.height == choice.height then
      if best == nil or math.abs(candidate.refresh_rate - wanted) < math.abs(best.refresh_rate - wanted) then
        best = candidate
      end
    end
  end
  if best == nil then
    return
  end
  apply({ output.name, "mode", modeKey(best) }, string.format("%s → %d × %d", output.name, best.width, best.height))
end

function onRefreshChange(index, label)
  local output = find(selected)
  if output == nil then
    return
  end
  local choice = refreshRates(output)[tonumber(index) + 1]
  if choice == nil then
    return
  end
  apply(
    { output.name, "mode", modeKey(choice) },
    string.format("%s → %.2f Hz", output.name, choice.refresh_rate / 1000)
  )
end

function onScaleChange(index, label)
  local output = find(selected)
  if output == nil then
    return
  end
  local scales = { 1, 1.25, 1.5, 1.75, 2, 2.5, 3 }
  local choice = scales[tonumber(index) + 1]
  if choice == nil then
    return
  end
  apply({ output.name, "scale", tostring(choice) }, string.format("%s → scale %s", output.name, tostring(choice)))
end

function onVrrToggle(state)
  local output = find(selected)
  if output == nil then
    return
  end
  local on = state == true or state == "true"
  apply({ output.name, "vrr", on and "on" or "off" }, string.format("%s → VRR %s", output.name, on and "on" or "off"))
end

function onPowerToggle(state)
  local output = find(selected)
  if output == nil then
    return
  end
  local on = state == true or state == "true"
  apply({ output.name, on and "on" or "off" }, string.format("%s → %s", output.name, on and "on" or "off"))
end

--- Reorder: lay the outputs out left to right in the dropped order, packing
--- each one against the right edge of the previous. Tops are aligned; niri
--- rejects overlapping outputs, so contiguous packing is the safe arrangement.
function onDisplayDropped(payload, value)
  local target = tonumber(value)
  if target == nil then
    return
  end

  local moved, fromIndex = nil, nil
  for i, output in ipairs(outputs) do
    if output.name == payload then
      moved, fromIndex = output, i
      break
    end
  end
  if moved == nil then
    return
  end

  table.remove(outputs, fromIndex)
  if fromIndex < target then
    target -= 1
  end
  target = math.max(1, math.min(target, #outputs + 1))
  table.insert(outputs, target, moved)

  applyArrangement(arrangement())
end

--- Lay the outputs out in their current order, packed edge to edge along the
--- chosen axis and flush on the other one. niri rejects overlapping outputs, so
--- contiguous packing is the arrangement that always takes.
function applyArrangement(mode)
  local offset = 0
  local queue = {}
  for _, output in ipairs(outputs) do
    local logical = output.logical or { width = 0, height = 0 }
    if mode == "vertical" then
      queue[#queue + 1] = { name = output.name, x = 0, y = offset }
      offset += logical.height or 0
    else
      queue[#queue + 1] = { name = output.name, x = offset, y = 0 }
      offset += logical.width or 0
    end
  end

  busy = true
  status = mode == "vertical" and "stacking…" or "rearranging…"
  render()

  -- Applied sequentially: each position depends on the size of the one before,
  -- and niri refuses a position that would overlap an output it has not moved
  -- yet, so these cannot be fired in parallel.
  local function step(i)
    if i > #queue then
      busy = false
      refresh(function()
        persist()
        status = "layout saved"
        render()
      end)
      return
    end
    local item = queue[i]
    -- `position set X Y`, positional — not `position x=N y=N`, which niri
    -- rejects with "unrecognized subcommand".
    noctalia.runAsync(
      niriCmd("output", item.name, "position", "set", tostring(item.x), tostring(item.y)),
      function(result)
        -- Check the exit code: silently ignoring it is what made a rejected
        -- move still report "layout saved" and then persist the old geometry.
        if result.exitCode ~= 0 then
          busy = false
          status = "could not move " .. item.name .. ": "
            .. (result.stderr ~= "" and result.stderr or "exit " .. result.exitCode)
          noctalia.notifyError("Displays", status)
          refresh()
          return
        end
        step(i + 1)
      end,
      8000
    )
  end
  step(1)
end

function onArrangementChange(index, label)
  local mode = tonumber(index) == 1 and "vertical" or "horizontal"
  if mode == arrangement() then
    return
  end
  -- Reorder along the new axis: top-to-bottom keeps the left-to-right order,
  -- so the display that was leftmost ends up on top.
  applyArrangement(mode)
end

function onRefreshClicked()
  refresh()
end

function onCloseClicked()
  panel.close()
end

-- ── view ────────────────────────────────────────────────────────────────────

--- A name worth showing. Laptop panels report junk EDID models ("0x4145"), so
--- an internal connector gets a friendly label the way macOS does.
local function displayTitle(output)
  if string.match(output.name, "^eDP") or string.match(output.name, "^LVDS") then
    return "Built-in Display"
  end
  local model = output.model or ""
  if model ~= "" and not string.match(model, "^0x%x+$") then
    return model
  end
  return output.name
end

local function displayTile(output, index)
  local isSelected = output.name == selected
  local mode = currentMode(output)
  local title = displayTitle(output)

  return ui.column({
    key = "tile-" .. output.name,
    gap = 4,
    align = "center",
    padding = 8,
    radius = 12,
    fill = isSelected and "primary/0.18" or "surface_variant/0.25",
    onClick = function()
      onSelect(output.name)
    end,
  }, {
    ui.dragSource({
      key = "drag-" .. output.name,
      dragType = "display",
      payload = output.name,
      previewAncestor = 1,
      liftFromLayout = false,
      tooltip = "Drag to reorder",
      width = 96,
      height = 56,
      align = "center",
      justify = "center",
    }, {
      -- A row, not ui.box: box is a leaf that draws a rectangle and drops its
      -- children, so the glyph never appeared inside one.
      ui.row({
        width = 92,
        height = 52,
        radius = 6,
        fill = isSelected and "primary/0.35" or "surface/0.9",
        align = "center",
        justify = "center",
      }, {
        ui.glyph({
          name = string.match(output.name, "^eDP") and "device-laptop" or "device-desktop",
          size = 22,
          color = isSelected and "primary" or "on_surface_variant",
        }),
      }),
    }),
    ui.label({ text = title or output.name, fontWeight = isSelected and "bold" or "normal", fontSize = 12 }),
    ui.label({
      text = mode ~= nil and string.format("%d×%d · %.0f Hz", mode.width, mode.height, mode.refresh_rate / 1000)
        or "off",
      fontSize = 10,
      color = "on_surface_variant",
    }),
  })
end

local function insertionZone(index, vertical)
  return ui.dropZone({
    key = "gap-" .. tostring(index),
    accepts = { "display" },
    value = tostring(index),
    onDrop = "onDisplayDropped",
    -- The zone straddles the gap between two tiles, so it is thin across the
    -- packing axis and long along it.
    width = vertical and 130 or 6,
    height = vertical and 6 or 90,
    direction = vertical and "vertical" or "horizontal",
    radius = 6,
    expandOnDrag = true,
    hitSlop = 24,
  })
end

--- The tiles are laid out on the same axis as the screens, so dragging one
--- reads as moving the physical display.
local function layoutStrip()
  local vertical = arrangement() == "vertical"
  local children = {}
  for i, output in ipairs(outputs) do
    children[#children + 1] = insertionZone(i, vertical)
    children[#children + 1] = displayTile(output, i)
  end
  children[#children + 1] = insertionZone(#outputs + 1, vertical)

  local props = { gap = 4, align = "center", justify = "center" }
  if vertical then
    return ui.column(props, children)
  end
  return ui.row(props, children)
end

local function settingsFor(output)
  local resolutionOptions, refreshOptions = {}, {}
  for _, item in ipairs(resolutions(output)) do
    resolutionOptions[#resolutionOptions + 1] = string.format("%d × %d", item.width, item.height)
  end
  for _, item in ipairs(refreshRates(output)) do
    refreshOptions[#refreshOptions + 1] = string.format("%.2f Hz", item.refresh_rate / 1000)
  end

  local mode = currentMode(output)
  local scales = { 1, 1.25, 1.5, 1.75, 2, 2.5, 3 }
  local scaleOptions = {}
  for _, value in ipairs(scales) do
    scaleOptions[#scaleOptions + 1] = tostring(value) .. "×"
  end

  local currentScale = output.logical ~= nil and output.logical.scale or 1
  -- Two-column grid. `width` on a label does not reserve space — the label
  -- shrinks to its text and the control starts wherever that ends, which is why
  -- the selects were ragged. A fixed-width row holds the column open instead.
  -- (ui.box is a leaf in this API: it draws a rectangle and ignores children,
  -- so it cannot be used as the column container.)
  local LABEL_COLUMN = 104

  local function labelled(text, control, dimmed)
    return ui.row({ gap = 10, align = "center" }, {
      ui.row({ width = LABEL_COLUMN, align = "center" }, {
        ui.label({
          text = text,
          fontSize = 12,
          color = dimmed and "on_surface_variant/0.4" or "on_surface_variant",
        }),
      }),
      control,
    })
  end

  return ui.column({ gap = 8 }, {
    labelled(
      "Resolution",
      ui.select({
        key = "res-" .. output.name,
        options = resolutionOptions,
        selectedIndex = mode ~= nil and indexOf(resolutions(output), function(item)
          return item.width == mode.width and item.height == mode.height
        end) or 0,
        onChange = "onResolutionChange",
        enabled = not busy,
        flexGrow = 1,
      })
    ),
    labelled(
      "Refresh rate",
      ui.select({
        key = "hz-" .. output.name,
        options = refreshOptions,
        selectedIndex = mode ~= nil and indexOf(refreshRates(output), function(item)
          return item.refresh_rate == mode.refresh_rate
        end) or 0,
        onChange = "onRefreshChange",
        enabled = not busy and #refreshOptions > 1,
        flexGrow = 1,
      })
    ),
    labelled(
      "Scale",
      ui.select({
        key = "scale-" .. output.name,
        options = scaleOptions,
        selectedIndex = indexOf(scales, function(value)
          return math.abs(value - currentScale) < 0.001
        end),
        onChange = "onScaleChange",
        enabled = not busy,
        flexGrow = 1,
      })
    ),
    labelled(
      "VRR",
      ui.row({ gap = 10, align = "center", flexGrow = 1 }, {
        ui.toggle({
          checked = output.vrr_enabled == true,
          onChange = "onVrrToggle",
          -- Greyed out rather than hidden, so it is clear the monitor is the
          -- limitation and not the panel.
          enabled = not busy and output.vrr_supported == true,
        }),
        ui.label({
          text = output.vrr_supported == true and "" or "not supported by this display",
          fontSize = 11,
          color = "on_surface_variant/0.6",
        }),
      }),
      output.vrr_supported ~= true
    ),
  })
end

function render()
  local body
  if #outputs == 0 then
    body = ui.column({ flexGrow = 1, align = "center", justify = "center" }, {
      ui.label({ text = status ~= "" and status or "No displays found", color = "on_surface_variant" }),
    })
  else
    local output = find(selected) or outputs[1]
    local vertical = arrangement() == "vertical"
    body = ui.column({ gap = 12, flexGrow = 1 }, {
      ui.row({ gap = 8, align = "center", justify = "center" }, {
        ui.label({ text = "Arrangement", fontSize = 12, color = "on_surface_variant" }),
        ui.select({
          key = "arrangement",
          options = { "Side by side", "Stacked" },
          selectedIndex = vertical and 1 or 0,
          onChange = "onArrangementChange",
          enabled = not busy and #outputs > 1,
        }),
      }),
      layoutStrip(),
      -- Hint and connector share one line: stacked mode is tall, and a separate
      -- row for the connector pushed the last control past the panel's edge.
      ui.row({ align = "center", justify = "space_between", gap = 8 }, {
        ui.label({
          text = vertical and "Drag a display to reorder it top to bottom."
            or "Drag a display to reorder it left to right.",
          fontSize = 11,
          color = "on_surface_variant",
        }),
        ui.label({
          text = string.format("%s · %s", output.name, output.make or ""),
          fontSize = 11,
          color = "on_surface_variant/0.7",
        }),
      }),
      ui.separator({}),
      settingsFor(output),
      ui.spacer({ flexGrow = 1 }),
      ui.label({ text = status, fontSize = 11, color = "on_surface_variant" }),
    })
  end

  panel.render(ui.column({ flexGrow = 1, gap = 12 }, {
    ui.row({ align = "center", gap = 8 }, {
      ui.label({ text = "Displays", fontSize = 16, fontWeight = "bold", flexGrow = 1 }),
      ui.button({ glyph = "refresh", tooltip = "Re-read from niri", onClick = "onRefreshClicked" }),
      ui.button({ glyph = "close", onClick = "onCloseClicked" }),
    }),
    body,
  }))
end

function onOpen(context)
  -- The script stays loaded between opens, so clear any status left over from
  -- the last session rather than greeting the user with a stale "rearranging…".
  busy = false
  status = ""
  refresh()
end

--- `noctalia msg plugin kevin/displays:panel <target> save` writes the current
--- layout to the generated config without changing anything — useful to capture
--- a layout you arranged by other means, and to seed the file the first time.
function onIpc(event, payload)
  if event == "save" then
    refresh(function()
      persist()
      status = "layout saved"
      render()
    end)
  elseif event == "refresh" then
    refresh()
  end
end
