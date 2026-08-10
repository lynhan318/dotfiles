#!/bin/bash
# Focus workspace N, always on the main screen.
#
# MAIN is the Samsung when it's plugged in; if it isn't, niri has put every
# workspace on the Yoga panel already, so we skip the monitor hop and just
# switch. Bound to Mod+1..4 (Mod+5 focuses the secondary screen directly).
WORKSPACE=$1
MAIN="HDMI-A-1"

CURRENT_OUTPUT=$(/usr/bin/niri msg -j focused-output | /usr/bin/jq -r '.name')
MAIN_CONNECTED=$(/usr/bin/niri msg -j outputs | /usr/bin/jq -r --arg m "$MAIN" 'has($m)')

if [ "$MAIN_CONNECTED" = "true" ] && [ "$CURRENT_OUTPUT" != "$MAIN" ]; then
    /usr/bin/niri msg action focus-monitor "$MAIN"
fi

/usr/bin/niri msg action focus-workspace "$WORKSPACE"
