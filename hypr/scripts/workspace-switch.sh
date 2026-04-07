#!/bin/bash
# Multi-monitor workspace switch helper
# Workspaces 1-3 live on DP-1 (primary), workspace 4 on HDMI-A-1 (secondary)
# When focused on HDMI-A-1, first switch focus to DP-1 before switching workspace

WORKSPACE=$1
CURRENT_MONITOR=$(hyprctl activeworkspace -j | jq -r '.monitor')

if [ "$CURRENT_MONITOR" = "HDMI-A-1" ]; then
    hyprctl dispatch focusmonitor DP-1
    hyprctl dispatch workspace "$WORKSPACE"
else
    hyprctl dispatch workspace "$WORKSPACE"
fi
