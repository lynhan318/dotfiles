#!/bin/bash
WORKSPACE=$1
CURRENT_OUTPUT=$(/usr/bin/niri msg -j focused-output | /usr/bin/jq -r '.name')

if [ "$WORKSPACE" = "4" ]; then
    IS_FLOATING=$(/usr/bin/niri msg -j focused-window | /usr/bin/jq -r '.is_floating')
    if [ "$IS_FLOATING" != "true" ]; then
        /usr/bin/niri msg action move-window-to-floating
    fi
    /usr/bin/niri msg action move-column-to-monitor "HDMI-A-1"
    /usr/bin/niri msg action center-window
elif [ "$CURRENT_OUTPUT" = "HDMI-A-1" ]; then
    /usr/bin/niri msg action move-column-to-monitor "DP-1"
    /usr/bin/niri msg action move-column-to-workspace "$WORKSPACE"
else
    /usr/bin/niri msg action move-column-to-workspace "$WORKSPACE"
fi
