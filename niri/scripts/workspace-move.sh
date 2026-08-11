#!/bin/bash
# Move the focused column to workspace N.
#
# Workspace 5 is special *while docked*: it's the floating scratch space on the
# secondary screen (the Yoga panel), so the window is floated and centered there
# instead of being tiled. 1-4 land on the main screen (the Samsung).
# Both hops are skipped when the target screen isn't connected.
#
# On the laptop alone there is no secondary screen and workspace 5 is an
# ordinary workspace — moving a window there tiles it like anywhere else.
WORKSPACE=$1
MAIN="HDMI-A-1"
SECONDARY="eDP-1"
FLOAT_WORKSPACE=5

CURRENT_OUTPUT=$(/usr/bin/niri msg -j focused-output | /usr/bin/jq -r '.name')
OUTPUTS=$(/usr/bin/niri msg -j outputs)
connected() { /usr/bin/jq -e -r --arg m "$1" 'has($m)' >/dev/null <<<"$OUTPUTS"; }

if [ "$WORKSPACE" = "$FLOAT_WORKSPACE" ] && connected "$MAIN"; then
    IS_FLOATING=$(/usr/bin/niri msg -j focused-window | /usr/bin/jq -r '.is_floating')
    if [ "$IS_FLOATING" != "true" ]; then
        /usr/bin/niri msg action move-window-to-floating
    fi
    if connected "$SECONDARY" && [ "$CURRENT_OUTPUT" != "$SECONDARY" ]; then
        /usr/bin/niri msg action move-column-to-monitor "$SECONDARY"
    fi
    /usr/bin/niri msg action center-window
elif connected "$MAIN" && [ "$CURRENT_OUTPUT" != "$MAIN" ]; then
    /usr/bin/niri msg action move-column-to-monitor "$MAIN"
    /usr/bin/niri msg action move-column-to-workspace "$WORKSPACE"
else
    /usr/bin/niri msg action move-column-to-workspace "$WORKSPACE"
fi
