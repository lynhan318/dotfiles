--!nonstrict
-- Lid Guard — control-center quick tile. Same client role as the bar widget,
-- so the guard is reachable with nothing placed on a bar.

local status = noctalia.state.get("status") or { active = false, available = false, reason = "" }
local requestId = 0

local function apply(value)
  if type(value) == "table" then
    status = value
  end

  local active = status.active == true
  shortcut.setLabel(if active then noctalia.tr("shortcut.on") else noctalia.tr("shortcut.off"))
  -- setIcon takes the active icon first, then the inactive one.
  shortcut.setIcon("device-laptop", "device-laptop-off")
  shortcut.setActive(active)
  -- Greyed out rather than hidden when the unit is missing: the tooltip on the
  -- bar widget explains why, and a tile that silently vanishes is a worse bug
  -- report than one that is visibly disabled.
  shortcut.setEnabled(status.available == true)
end

apply(status)
noctalia.state.watch("status", apply)

function onClick()
  requestId += 1
  noctalia.state.set("command", { action = "toggle", requestId = `shortcut-{requestId}` })
end
