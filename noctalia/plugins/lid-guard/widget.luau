--!nonstrict
-- Lid Guard — bar tile.
--
-- Holds no logic: it mirrors the service's "status" and posts to "command".
-- The service is what talks to systemd, so this stays correct even when the
-- unit is toggled from a terminal or the control-center tile.

local status = noctalia.state.get("status") or { active = false, available = false, reason = "" }
local requestId = 0

local function configString(key, fallback)
  local value = noctalia.getConfig(key)
  return if type(value) == "string" then value else fallback
end

local function render()
  local active = status.active == true
  local available = status.available == true

  local color = if not available
    then "on_surface_variant"
    elseif active then configString("active_color", "primary")
    else configString("inactive_color", "on_surface")

  -- `device-laptop` / `device-laptop-off` follows the shell's own on/off icon
  -- pairing (the recorder does video / video-off): the struck-through variant
  -- means the *feature* is off, not that the laptop is.
  local container = if barWidget.isVertical() then ui.column else ui.row
  barWidget.render(container({ gap = 4, align = "center" }, {
    ui.glyph({
      name = if active then "device-laptop" else "device-laptop-off",
      size = 16,
      color = color,
    }),
  }))

  barWidget.setTooltip(
    if not available then status.reason or noctalia.tr("error.unavailable")
    elseif active then noctalia.tr("tooltip.on")
    else noctalia.tr("tooltip.off")
  )
end

noctalia.state.watch("status", function(value)
  if type(value) == "table" then
    status = value
    render()
  end
end)

render()

function onClick()
  -- The counter is the point: a watcher fires on *change*, and two identical
  -- {action="toggle"} tables in a row are not one.
  requestId += 1
  noctalia.state.set("command", { action = "toggle", requestId = `widget-{requestId}` })
end

function onRightClick()
  requestId += 1
  noctalia.state.set("command", { action = "refresh", requestId = `widget-{requestId}` })
end
