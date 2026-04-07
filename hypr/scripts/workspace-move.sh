#!/bin/bash
# Multi-monitor workspace move helper
# Workspace 4 -> auto-float + send to HDMI-A-1
# From HDMI-A-1 to workspaces 1-3 -> move to DP-1 first

WORKSPACE=$1
CURRENT_MONITOR=$(hyprctl activeworkspace -j | jq -r '.monitor')

if [ "$WORKSPACE" = "4" ]; then
    # Auto-float the window and send to HDMI-A-1
    FLOATING=$(hyprctl activewindow -j | jq -r '.floating')
    if [ "$FLOATING" != "true" ]; then
        hyprctl dispatch togglefloating
    fi
    hyprctl dispatch movetoworkspace 4
    hyprctl dispatch centerwindow 1
elif [ "$CURRENT_MONITOR" = "HDMI-A-1" ]; then
    # Moving from secondary to primary monitor workspace
    hyprctl dispatch movetoworkspace "$WORKSPACE"
else
    hyprctl dispatch movetoworkspace "$WORKSPACE"
fi
