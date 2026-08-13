#!/bin/bash
# Move the focused column to workspace N.
#
# 1-4 live on the main screen (the Samsung), 5 on the Yoga panel, so the column
# hops outputs first when it isn't already on the right one. eDP-1 carries only
# workspace 5, so arriving on that output is enough — there is nowhere else on
# it to land. Both hops are skipped when the target screen isn't connected.
#
# On the laptop alone there is no secondary screen and workspace 5 is an
# ordinary workspace, reached by the plain move below like any other.
WORKSPACE=$1
MAIN="HDMI-A-1"
SECONDARY="eDP-1"
SECONDARY_WORKSPACE=5

CURRENT_OUTPUT=$(/usr/bin/niri msg -j focused-output | /usr/bin/jq -r '.name')
OUTPUTS=$(/usr/bin/niri msg -j outputs)
connected() { /usr/bin/jq -e -r --arg m "$1" 'has($m)' >/dev/null <<<"$OUTPUTS"; }

if [ "$WORKSPACE" = "$SECONDARY_WORKSPACE" ] && connected "$MAIN"; then
    if connected "$SECONDARY" && [ "$CURRENT_OUTPUT" != "$SECONDARY" ]; then
        /usr/bin/niri msg action move-column-to-monitor "$SECONDARY"
    fi
elif connected "$MAIN" && [ "$CURRENT_OUTPUT" != "$MAIN" ]; then
    /usr/bin/niri msg action move-column-to-monitor "$MAIN"
    /usr/bin/niri msg action move-column-to-workspace "$WORKSPACE"
else
    /usr/bin/niri msg action move-column-to-workspace "$WORKSPACE"
fi
