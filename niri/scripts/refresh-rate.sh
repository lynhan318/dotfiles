#!/bin/bash
# Match the built-in panel refresh rate to AC power state.
# 120 Hz plugged in, 60 Hz on battery — the panel has no VRR, so the only
# way to avoid paying for 120 Hz on static content is to drop the mode.
#
# Run with no argument to watch for power events; "once" to apply and exit.

OUTPUT="eDP-1"
MODE_AC="3000x1876@120.001"
MODE_BAT="3000x1876@60.000"
AC_ONLINE="${AC_ONLINE:-/sys/class/power_supply/ACAD/online}"

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

apply() {
    find_socket || return 1

    if [ "$(/usr/bin/cat "$AC_ONLINE" 2>/dev/null)" = "1" ]; then
        /usr/bin/niri msg output "$OUTPUT" mode "$MODE_AC"
    else
        /usr/bin/niri msg output "$OUTPUT" mode "$MODE_BAT"
    fi
}

if [ "$1" = "once" ]; then
    apply
    exit $?
fi

apply

# Each plug/unplug emits several events across ACAD and the USB-C PD ports.
# Block for the first one, drain the rest of the burst, then switch once.
/usr/bin/udevadm monitor --udev --subsystem-match=power_supply | while read -r _; do
    while read -r -t 1 _; do :; done
    apply
done
