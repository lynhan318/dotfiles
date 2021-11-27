#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar

case $1 in
float)
  polybar -q main -c "$DIR"/configs/float/config.ini &
  ;;
*)
  polybar -q main -c "$DIR"/configs/normal/config.ini &
  ;;
esac
