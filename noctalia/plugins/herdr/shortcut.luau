--!nonstrict
-- Control-center tile: opens the Herdr Sessions panel.

shortcut.setLabel("Herdr Sessions")
shortcut.setIcon("terminal-2")
shortcut.setEnabled(true)

function onClick()
  noctalia.togglePanel("kevin/herdr:panel")
end
