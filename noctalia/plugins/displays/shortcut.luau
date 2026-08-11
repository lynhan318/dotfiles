--!nonstrict
-- Control-center tile: opens the Displays panel.

shortcut.setLabel("Displays")
shortcut.setIcon("device-desktop")
shortcut.setEnabled(true)

function onClick()
  noctalia.togglePanel("kevin/displays:panel")
end
