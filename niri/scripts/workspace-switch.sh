#!/bin/bash
WORKSPACE=$1
CURRENT_OUTPUT=$(/usr/bin/niri msg -j focused-output | /usr/bin/jq -r '.name')

if [ "$CURRENT_OUTPUT" = "HDMI-A-1" ]; then
    /usr/bin/niri msg action focus-monitor "DP-1"
    /usr/bin/niri msg action focus-workspace "$WORKSPACE"
else
    /usr/bin/niri msg action focus-workspace "$WORKSPACE"
fi
