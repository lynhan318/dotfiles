#!/bin/bash
# Float every window that lands on the secondary screen.
#
# niri window rules can't match on output or workspace — only on app-id/title
# and window state — so "anything that opens over there is floating" can't be
# expressed in config.kdl. This watches niri's event stream instead and floats
# each window as it arrives on the secondary output.
#
# It keys off the output, not the workspace name, because that screen always has
# at least two workspaces: "5: float" plus the empty one niri keeps at the end
# of every output. A window can open on either.
#
# "Secondary" is a role, not a screen: it only exists while the main screen is
# also connected. On the laptop alone, eDP-1 IS the main screen and nothing is
# floated — otherwise every window on an undocked laptop would open floating.
#
# Arrival, not state, is the trigger: a window is only floated when the
# workspace it sits on *changes* (or when it first appears). Toggling a window
# back to tiling with Mod+Space is therefore left alone instead of being
# instantly undone.
#
# Started from config.kdl via spawn-at-startup, so it normally inherits
# NIRI_SOCKET and dies with the compositor. The socket is rediscovered anyway so
# the script also works when launched by hand or from a systemd user unit.

SECONDARY="eDP-1"
MAIN="HDMI-A-1"

if [ -z "$NIRI_SOCKET" ] || [ ! -S "$NIRI_SOCKET" ]; then
    NIRI_SOCKET=$(/usr/bin/ls -t "${XDG_RUNTIME_DIR:-/run/user/$(/usr/bin/id -u)}"/niri.wayland-*.sock 2>/dev/null | /usr/bin/head -1)
    export NIRI_SOCKET
fi

# workspace id -> output name. niri's window events carry only the workspace id.
declare -A WS_OUTPUT
declare -A LAST_WS
MAIN_CONNECTED=false

refresh_workspaces() {
    local id output
    WS_OUTPUT=()
    MAIN_CONNECTED=false
    while read -r id output; do
        WS_OUTPUT[$id]="$output"
        # niri keeps at least one workspace on every connected output, so the
        # workspace list doubles as the list of connected screens — no second
        # IPC call needed.
        [ "$output" = "$MAIN" ] && MAIN_CONNECTED=true
    done < <(/usr/bin/niri msg -j workspaces | /usr/bin/jq -r '.[] | "\(.id) \(.output)"')
}

refresh_workspaces

# Windows that already exist are not arrivals. niri emits WindowOpenedOrChanged
# for every window when the stream opens, so without this a restart mid-session
# (or a hotplug) would treat the whole desktop as newly arrived and float it.
prime_windows() {
    local id ws
    while read -r id ws; do
        LAST_WS[$id]="$ws"
    done < <(/usr/bin/niri msg -j windows | /usr/bin/jq -r '.[] | "\(.id) \(.workspace_id)"')
}

prime_windows

/usr/bin/niri msg -j event-stream | while read -r line; do
    case "$line" in
        *'"WorkspacesChanged"'*)
            refresh_workspaces
            continue
            ;;
        *'"WindowClosed"'*)
            id=$(/usr/bin/jq -r '.WindowClosed.id' <<<"$line")
            unset "LAST_WS[$id]"
            continue
            ;;
        *'"WindowOpenedOrChanged"'*) ;;
        *) continue ;;
    esac

    read -r id ws floating < <(
        /usr/bin/jq -r '.WindowOpenedOrChanged.window
                        | "\(.id) \(.workspace_id) \(.is_floating)"' <<<"$line"
    )
    [ -z "$id" ] && continue

    previous="${LAST_WS[$id]}"
    LAST_WS[$id]="$ws"

    # Same workspace as last time => not an arrival (a title change, a focus
    # change, or the user deliberately tiling it). Leave it be.
    [ "$previous" = "$ws" ] && continue
    [ "$floating" = "true" ] && continue

    # A window can open onto a workspace niri has only just created, before the
    # matching WorkspacesChanged arrives — look it up again before giving up.
    [ -z "${WS_OUTPUT[$ws]}" ] && refresh_workspaces

    if [ "$MAIN_CONNECTED" = true ] && [ "${WS_OUTPUT[$ws]}" = "$SECONDARY" ]; then
        /usr/bin/niri msg action move-window-to-floating --id "$id"
        /usr/bin/niri msg action center-window --id "$id"
    fi
done
