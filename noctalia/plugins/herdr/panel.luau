--!nonstrict
-- Herdr Sessions — list every herdr session, click one to attach in a new
-- terminal window.
--
-- Live state comes from `herdr session list --json`:
--
--   {"sessions":[{"default":true,"name":"default","running":false,
--                 "session_dir":"/home/kevin/.config/herdr",
--                 "socket_path":"/home/kevin/.config/herdr/herdr.sock"}]}

--- Noctalia is started from niri's `spawn-at-startup`, whose PATH does not
--- include ~/.local/bin — and that is where herdr installs itself. Both the
--- listing call and the spawned terminal get it put back, so a bare `herdr` in
--- the herdr_path setting still resolves.
local PATH_FIX = 'PATH="$HOME/.local/bin:$PATH" '

--- Everything herdr uses to recognise "I am already running in a session".
--- Cleared for the spawned window so it starts as a fresh top-level client;
--- see the comment at the spawn site.
local HERDR_ENV_STRIP = "env"
  .. " -u HERDR_ENV"
  .. " -u HERDR_SESSION"
  .. " -u HERDR_SOCKET_PATH"
  .. " -u HERDR_PANE_ID"
  .. " -u HERDR_TAB_ID"
  .. " -u HERDR_WORKSPACE_ID"
  .. " "

--- runAsync's argv-table form needs a newer plugin_api than this targets; the
--- string form runs through /bin/sh -c and works everywhere, so commands are
--- assembled by hand. Single-quoted with the '\'' escape — session names are
--- constrained, but a session_dir or a re-pointed binary path is not.
local function quote(value)
  return "'" .. string.gsub(tostring(value), "'", "'\\''") .. "'"
end

local sessions = {}
local status = ""
local loading = false

-- getConfig reads one key at a time; there is no "give me the whole table" form.
local function setting(key, fallback)
  local value = noctalia.getConfig(key)
  if type(value) ~= "string" or value == "" then
    return fallback
  end
  return value
end

local function config()
  return {
    -- expandPath leaves a bare name ("herdr") alone, which PATH_FIX then
    -- resolves — so both a full path and a bare name work here.
    herdr = noctalia.expandPath(setting("herdr_path", "~/.local/bin/herdr")),
    term = setting("terminal", "ghostty"),
    appId = setting("app_id", "local.maximized.herdr"),
  }
end

-- ── herdr CLI ───────────────────────────────────────────────────────────────

local function refresh()
  loading = true
  render()

  local cfg = config()
  noctalia.runAsync(PATH_FIX .. quote(cfg.herdr) .. " session list --json", function(result)
    loading = false

    if result.exitCode ~= 0 then
      sessions = {}
      local detail = result.stderr ~= "" and result.stderr or "exit " .. result.exitCode
      -- 127 is sh's "not found", which here almost always means herdr lives
      -- somewhere other than the configured path rather than being broken.
      if result.exitCode == 127 then
        status = "herdr not found at " .. cfg.herdr .. " — set it in the plugin settings"
      else
        status = "herdr is not answering: " .. detail
      end
      render()
      return
    end

    local decoded, err = noctalia.json.decode(result.stdout)
    if decoded == nil then
      sessions = {}
      status = "could not parse 'herdr session list --json': " .. tostring(err)
      render()
      return
    end

    sessions = decoded.sessions or {}
    -- The default session first, then the rest by name: the default is the one
    -- with no `--session` flag and it should not shuffle around as others come
    -- and go.
    table.sort(sessions, function(a, b)
      if (a.default == true) ~= (b.default == true) then
        return a.default == true
      end
      return tostring(a.name) < tostring(b.name)
    end)

    status = ""
    render()
  end, 5000)
end

--- Attach to a session in its own terminal window.
---
--- The default session is not addressable by name: `herdr --session default`
--- would create a *new* named session under ~/.config/herdr/sessions/default,
--- next to the real default at ~/.config/herdr. Bare `herdr` is the only way to
--- reach it. For everything else `herdr --session <name>` both creates and
--- attaches, so this one call covers a stopped session too.
local function attach(session)
  local cfg = config()

  local parts = {
    PATH_FIX,
    -- setsid + & so the window outlives this panel: without it the terminal is
    -- a child of the shell runAsync spawned, and runAsync's timeout would reap
    -- a session the moment it got interesting.
    "setsid ",
    -- The new window must not look like it is *inside* a herdr session, or
    -- herdr refuses to start with "nested herdr is disabled by default".
    -- Noctalia normally gets a clean environment from niri's spawn-at-startup,
    -- but it inherits these the moment the shell is restarted by hand from a
    -- herdr window — and then every session opened from this panel dies.
    HERDR_ENV_STRIP,
    quote(cfg.term),
    " --class=" .. quote(cfg.appId),
    " --title=" .. quote("herdr: " .. tostring(session.name)),
    -- Ghostty wants --key=value; a space-separated flag is silently not parsed.
    -- -e must come last, and everything after it is the command.
    " -e ",
    quote(cfg.herdr),
  }
  if session.default ~= true then
    parts[#parts + 1] = " --session " .. quote(session.name)
  end
  parts[#parts + 1] = " >/dev/null 2>&1 &"

  noctalia.runAsync(table.concat(parts), function(result)
    -- The `&` means sh returns before the terminal has really started, so a
    -- zero exit here only says the shell accepted the line. A non-zero one is
    -- still worth surfacing.
    if result.exitCode ~= 0 then
      noctalia.notifyError(
        "Herdr",
        "could not start " .. cfg.term .. ": "
          .. (result.stderr ~= "" and result.stderr or "exit " .. result.exitCode)
      )
    end
  end, 5000)

  panel.close()
end

-- ── actions ─────────────────────────────────────────────────────────────────

function onRefreshClicked()
  refresh()
end

function onCloseClicked()
  panel.close()
end

-- ── view ────────────────────────────────────────────────────────────────────

local function sessionRow(session)
  local running = session.running == true
  return ui.column({
    key = "session-" .. tostring(session.name),
    gap = 2,
    padding = 8,
    radius = 10,
    fill = "surface_variant/0.35",
    onClick = function()
      attach(session)
    end,
  }, {
    ui.row({ gap = 8, align = "center" }, {
      ui.glyph({
        name = "terminal-2",
        size = 16,
        color = running and "primary" or "on_surface_variant",
      }),
      ui.label({
        text = tostring(session.name),
        fontWeight = "bold",
        fontSize = 13,
        flexGrow = 1,
        maxLines = 1,
      }),
      ui.label({
        text = session.default == true and "default" or "",
        fontSize = 10,
        color = "on_surface_variant/0.7",
      }),
      ui.label({
        text = running and "running" or "stopped",
        fontSize = 10,
        color = running and "primary" or "on_surface_variant/0.7",
      }),
    }),
    ui.label({
      text = tostring(session.session_dir or ""),
      fontSize = 10,
      color = "on_surface_variant/0.7",
      maxLines = 1,
    }),
  })
end

local function body()
  if status ~= "" then
    return ui.column({ flexGrow = 1, align = "center", justify = "center", padding = 16, gap = 8 }, {
      ui.glyph({ name = "alert-triangle", size = 32, color = "on_surface_variant" }),
      ui.label({ text = status, color = "on_surface_variant", textAlign = "center", maxLines = 4 }),
    })
  end

  if #sessions == 0 then
    return ui.column({ flexGrow = 1, align = "center", justify = "center", padding = 16, gap = 8 }, {
      ui.glyph({ name = "terminal-2", size = 32, color = "on_surface_variant" }),
      ui.label({
        text = loading and "Loading…" or "No herdr sessions",
        color = "on_surface_variant",
      }),
    })
  end

  local rows = {}
  for _, session in ipairs(sessions) do
    rows[#rows + 1] = sessionRow(session)
  end
  -- justify "start" so the list stacks from the top rather than floating in the
  -- middle of the panel, and align "stretch" so each row fills the width instead
  -- of shrinking to its own text — otherwise the rows come out ragged and the
  -- click target is only as wide as the session name.
  return ui.scroll({ flexGrow = 1, gap = 6, justify = "start", align = "stretch" }, rows)
end

function render()
  panel.render(ui.column({ flexGrow = 1, gap = 10 }, {
    ui.row({ align = "center", gap = 8 }, {
      ui.label({ text = "Herdr Sessions", fontSize = 16, fontWeight = "bold", flexGrow = 1 }),
      ui.button({ glyph = "refresh", tooltip = "Re-read from herdr", onClick = "onRefreshClicked" }),
      ui.button({ glyph = "close", onClick = "onCloseClicked" }),
    }),
    body(),
    ui.label({
      text = "Click a session to open it in " .. config().term .. ".",
      fontSize = 11,
      color = "on_surface_variant",
    }),
  }))
end

function onOpen(context)
  -- The script stays loaded between opens, so a session started or stopped
  -- elsewhere since last time is picked up rather than shown stale.
  status = ""
  refresh()
end

function onIpc(event, payload)
  if event == "refresh" then
    refresh()
  end
end
