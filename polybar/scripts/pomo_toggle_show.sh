#!/bin/bash

if pgrep pomotroid | grep '.' >/dev/null; then
  if xdotool search --onlyvisible --name ".*pomotroid" | grep '.' >/dev/null; then
    echo "CurrentState: Visible"
    xdotool search --name ".*omotroid" windowunmap
  else
    echo "CurrentState: Hidden"
    if pgrep pomotroid | grep '.' >/dev/null; then
      xdotool search --name ".*omotroid" windowmap set_desktop_for_window $(xdotool get_desktop)
    else
      echo "Start new pomotroid instance"
      pomotroid &
    fi
  fi
else
  echo "Start new pomotroid instance"
  pomotroid &
fi
