#!/bin/bash
# Match the built-in panel refresh rate to AC power state and to whether an
# external monitor is attached.
#
# 120 Hz only when the panel is on AC *and* driving the machine alone; 60 Hz
# otherwise. The panel has no VRR, so dropping the mode is the only way to
# avoid paying for 120 Hz on static content.
#
# The external-monitor half is not about power. 3000x1876@120 alongside the
# 4K@60 Samsung exceeds what this Arrow Lake display engine will carry, and the
# symptom is the built-in panel visibly flickering. Nothing is logged when it
# happens -- no FIFO underrun, no link-training failure, clean i915 and niri
# logs -- so the only evidence is on the glass: at 60 Hz with the external
# attached the flicker stops, at 120 Hz it comes back.
#
# Run with no argument to watch for power events; "once" to apply and exit.

OUTPUT="eDP-1"
MODE_AC="3000x1876@120.001"
MODE_BAT="3000x1876@60.000"
AC_ONLINE="${AC_ONLINE:-/sys/class/power_supply/ACAD/online}"
# Overridable so the connected/not-connected branches can be exercised against
# a fake tree without unplugging anything.
DRM_DIR="${DRM_DIR:-/sys/class/drm}"

# systemd user services don't inherit NIRI_SOCKET, so rediscover it each time:
# the socket name carries niri's PID and changes across compositor restarts.
find_socket() {
    if [ -n "$NIRI_SOCKET" ] && [ -S "$NIRI_SOCKET" ]; then
        return 0
    fi
    NIRI_SOCKET=$(/usr/bin/ls -t "${XDG_RUNTIME_DIR:-/run/user/$(/usr/bin/id -u)}"/niri.wayland-*.sock 2>/dev/null | /usr/bin/head -1)
    export NIRI_SOCKET
    [ -S "$NIRI_SOCKET" ]
}

# Any connected output that is not the built-in panel. Read from DRM sysfs
# rather than `niri msg outputs`: this has to be right in the middle of a
# hotplug burst, before niri has settled on a configuration, and sysfs flips to
# "connected" as soon as the kernel sees the connector.
external_connected() {
    local status
    for status in "$DRM_DIR"/card*-*/status; do
        case "$status" in
            */card*-eDP-*) continue ;;
        esac
        [ "$(/usr/bin/cat "$status" 2>/dev/null)" = "connected" ] && return 0
    done
    return 1
}

apply() {
    find_socket || return 1

    if [ "$(/usr/bin/cat "$AC_ONLINE" 2>/dev/null)" = "1" ] && ! external_connected; then
        /usr/bin/niri msg output "$OUTPUT" mode "$MODE_AC"
    else
        /usr/bin/niri msg output "$OUTPUT" mode "$MODE_BAT"
    fi
}

# niri throws away IPC mode overrides on every config reload — "If the output
# configuration subsequently changes in the config file, these temporary changes
# will be forgotten" — and displays-generated.kdl deliberately carries no mode
# line for this panel, so a reload drops it back to the preferred 60 Hz. Watch
# for ConfigLoaded and re-assert the AC-appropriate mode.
watch_config_reloads() {
    while :; do
        if find_socket; then
            /usr/bin/niri msg --json event-stream 2>/dev/null | while read -r line; do
                case "$line" in
                    *'"ConfigLoaded"'*) apply ;;
                esac
            done
        fi
        # Stream ended: niri restarted or is not up yet. Its socket name carries
        # the PID, so back off and let find_socket pick up the new one.
        sleep 5
    done
}

if [ "$1" = "once" ]; then
    apply
    exit $?
fi

apply

watch_config_reloads &
CONFIG_WATCHER=$!
trap 'kill "$CONFIG_WATCHER" 2>/dev/null' EXIT INT TERM

# Each plug/unplug emits several events across ACAD and the USB-C PD ports.
# Block for the first one, drain the rest of the burst, then switch once.
#
# drm is matched alongside power_supply because a monitor plugged in while
# already on AC changes the answer without any power event firing at all.
/usr/bin/udevadm monitor --udev --subsystem-match=power_supply --subsystem-match=drm | while read -r _; do
    while read -r -t 1 _; do :; done
    apply
done
