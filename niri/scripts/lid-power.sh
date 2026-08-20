#!/bin/bash
# Everything that happens when the lid shuts, and its exact undo on open:
#
#   close -> panel to 5%, CPU to power-saver
#   open  -> both back to whatever they were before
#
# Wired to niri's switch-events in config.kdl. The brightness half only means
# anything alongside the `keep-laptop-panel-on-when-lid-is-closed` debug flag
# there: niri's default is to blank the panel outright on lid close, and
# dimming a backlight that is already off is a no-op you would notice only as a
# flash of 5% on the way back up.
#
# Both knobs go through `noctalia msg` so the bar's brightness and power-profile
# widgets follow along; setting them underneath the shell leaves it showing the
# old values until something else nudges it. The power profile falls back to
# powerprofilesctl, which talks to the same daemon, for the case where the lid
# shuts while the shell is restarting.

OUTPUT="eDP-1"
DIM_PERCENT=5
CLOSED_PROFILE="power-saver"

# Cleared on logout with the rest of the runtime dir, which is what we want: a
# value saved before a reboot is meaningless afterwards.
STATE="${XDG_RUNTIME_DIR:-/tmp}/lid-power.state"

# Read back from the kernel rather than remembered, so it reflects whatever
# last set it — a hotkey, the bar, or this script.
current_percent() {
    local dev cur max
    for dev in /sys/class/backlight/*/; do
        [[ -r "$dev/brightness" && -r "$dev/max_brightness" ]] || continue
        cur=$(< "$dev/brightness")
        max=$(< "$dev/max_brightness")
        (( max > 0 )) || continue
        # Rounded, not truncated: this panel sits at 131/504, which is 25.99%.
        # Truncating would shave a step off every close/open cycle and walk the
        # brightness down over a day.
        echo $(( (cur * 100 + max / 2) / max ))
        return 0
    done
    return 1
}

set_percent() {
    noctalia msg brightness-set "$OUTPUT" "$1" > /dev/null 2>&1
}

set_profile() {
    noctalia msg power-set "$1" > /dev/null 2>&1 ||
        powerprofilesctl set "$1" > /dev/null 2>&1
}

case "${1:-}" in
    close)
        # Save only on the first close. niri re-emits lid-close on a
        # suspend/resume cycle that happens with the lid still shut, and a
        # second save would record the dimmed, power-saving state as "what it
        # was before", making both permanent.
        if [[ ! -s "$STATE" ]]; then
            {
                percent=$(current_percent) && echo "brightness=$percent"
                profile=$(powerprofilesctl get 2>/dev/null) && echo "profile=$profile"
            } > "$STATE"
        fi
        set_percent "$DIM_PERCENT"
        set_profile "$CLOSED_PROFILE"
        ;;
    open)
        # Nothing saved means we never dimmed — leave the machine alone rather
        # than guessing values.
        [[ -s "$STATE" ]] || exit 0
        brightness="" profile=""
        while IFS='=' read -r key value; do
            case "$key" in
                brightness) brightness=$value ;;
                profile)    profile=$value ;;
            esac
        done < "$STATE"
        rm -f "$STATE"
        [[ "$brightness" =~ ^[0-9]+$ ]] && set_percent "$brightness"
        [[ -n "$profile" ]] && set_profile "$profile"
        ;;
    *)
        echo "usage: ${0##*/} close|open" >&2
        exit 2
        ;;
esac
