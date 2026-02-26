#!/bin/bash
WORKSPACE=$1
CURRENT_OUTPUT=$(/usr/bin/niri msg -j focused-output | /usr/bin/jq -r '.name')

if [ "$WORKSPACE" = "5" ]; then
    /usr/bin/niri msg action move-column-to-monitor "HDMI-A-1"
elif [ "$CURRENT_OUTPUT" = "HDMI-A-1" ]; then
    /usr/bin/niri msg action move-column-to-monitor "DP-1"
    /usr/bin/niri msg action move-column-to-workspace "$WORKSPACE"
else
    /usr/bin/niri msg action move-column-to-workspace "$WORKSPACE"
fi
