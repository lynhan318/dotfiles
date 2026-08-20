--!nonstrict
-- Lid Guard — headless service. Owns the state; the widget and the
-- control-center tile are views onto it.
--
-- The state is not a variable in here, it is whether lid-guard.service is
-- running. That unit holds a `handle-lid-switch` inhibitor lock and does
-- nothing else, so "is the lock held" and "is the unit up" are the same
-- question, and both survive a shell restart. Everything below is bookkeeping
-- around two systemctl calls.
--
--   status  (published) -> { active, available, reason }
--   command (consumed)  -> { action = "toggle" | "on" | "off" | "refresh" }

local UNIT = "lid-guard.service"
local POLL_MS = 5000

local available = false
local active = false
local reason = ""

--- Set from the moment a start/stop is sent until its result lands. A poll
--- that finishes inside that window reports the state we are moving *away*
--- from, so polls are skipped rather than allowed to flip the icon back and
--- forth under the click.
local inFlight = false

local function publish()
  noctalia.state.set("status", { active = active, available = available, reason = reason })
end

local function poll()
  if inFlight then
    return
  end

  -- `show` rather than `is-active`, because one call answers both questions and
  -- exits 0 either way: a unit that was never installed comes back as
  -- LoadState=not-found, which `is-active` reports as plain "inactive" — the
  -- same answer it gives for an installed unit that is simply switched off.
  noctalia.runAsync("systemctl --user show -p LoadState -p ActiveState " .. UNIT, function(result)
    if result.exitCode ~= 0 then
      available, active = false, false
      reason = noctalia.tr("error.no_systemctl")
      publish()
      return
    end

    local load = string.match(result.stdout, "LoadState=(%S+)") or "not-found"
    local state = string.match(result.stdout, "ActiveState=(%S+)") or "inactive"

    available = load == "loaded"
    -- "activating" counts as on: systemd reports it for the moment between fork
    -- and exec, and treating it as off would blink the icon on every toggle.
    active = available and (state == "active" or state == "activating")
    reason = if available then "" else noctalia.tr("error.not_installed", { unit = UNIT })
    publish()
  end, 5000)
end

local function setGuard(on)
  if not available then
    noctalia.notifyError(noctalia.tr("title"), reason)
    return
  end
  if on == active then
    return
  end

  inFlight = true
  local verb = if on then "start" else "stop"
  noctalia.runAsync("systemctl --user " .. verb .. " " .. UNIT, function(result)
    inFlight = false

    if result.exitCode ~= 0 then
      noctalia.notifyError(
        noctalia.tr("title"),
        if result.stderr ~= "" then result.stderr else "exit " .. result.exitCode
      )
      -- Do not assume the failure left the unit alone; ask.
      poll()
      return
    end

    active = on
    publish()
    -- Worth a toast: this is a change you will not see any other evidence of
    -- until you shut the lid and find out the hard way which way it went.
    noctalia.notify(noctalia.tr("title"), if on then noctalia.tr("notify.on") else noctalia.tr("notify.off"))
  end, 10000)
end

local function dispatch(action)
  if action == "toggle" then
    setGuard(not active)
  elseif action == "on" then
    setGuard(true)
  elseif action == "off" then
    setGuard(false)
  elseif action == "refresh" then
    poll()
  end
end

-- Clients never touch systemd themselves; they post an action here.
noctalia.state.watch("command", function(cmd)
  if type(cmd) == "table" then
    dispatch(cmd.action)
  end
end)

-- `noctalia msg plugin kevin/lid-guard:service service <event>` — a keybind or
-- a script can drive this with no widget on any bar.
function onIpc(event, payload)
  dispatch(event)
end

-- Polled, not just event-driven, because the unit can be started or stopped
-- from anywhere: a terminal, a niri bind, or systemd giving up on it. The
-- widget should show what is true, not what it last did.
noctalia.setUpdateInterval(POLL_MS)

function update()
  poll()
end

poll()
