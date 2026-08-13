#!/bin/bash
# Take a screenshot with niri's own picker, then open it in satty to annotate,
# instead of dropping it silently into the clipboard.
#
# niri's screenshot actions accept --path (26.04+), so the compositor keeps
# ownership of the selection UI — which snaps to windows and output edges, and
# is nicer than slurp for that reason — and this script only takes over what
# happens after the shutter. --path replaces the `screenshot-path` config
# setting rather than adding to it, so the un-annotated original never reaches
# ~/Pictures; the only file saved there is the one that came out of satty.
set -eu

MODE=${1:-region}
SAVE_DIR="$HOME/Pictures/Screenshots"
SHOT="${XDG_RUNTIME_DIR:-/tmp}/niri-shot-$$.png"

trap 'rm -f "$SHOT"' EXIT
mkdir -p "$SAVE_DIR"
rm -f "$SHOT"

case "$MODE" in
    region) niri msg action screenshot --path "$SHOT" ;;
    screen) niri msg action screenshot-screen --path "$SHOT" ;;
    window) niri msg action screenshot-window --path "$SHOT" ;;
    *) echo "usage: ${0##*/} {region|screen|window}" >&2; exit 2 ;;
esac

# `niri msg action` returns as soon as the request is queued — about 20 ms, well
# before the PNG exists — and in region mode it returns before the selection has
# even been drawn. Hence the wait. Escape in the picker means the file never
# arrives at all, so this gives up quietly rather than reporting an error.
deadline=$((SECONDS + 120))
while [ ! -s "$SHOT" ]; do
    if [ "$SECONDS" -ge "$deadline" ]; then
        exit 0
    fi
    sleep 0.1
done

# The file shows up before it is fully written, so let the size settle instead
# of handing satty a truncated PNG.
prev=-1
size=$(stat -c %s "$SHOT")
while [ "$size" != "$prev" ]; do
    prev=$size
    sleep 0.1
    size=$(stat -c %s "$SHOT")
done

# Ctrl+S saves the annotated copy (satty expands the strftime escapes itself),
# Ctrl+C or Enter copies it. --early-exit closes the window after either, so the
# editor behaves like a shutter confirmation rather than a window to manage.
satty --filename "$SHOT" \
    --output-filename "$SAVE_DIR/Screenshot from %Y-%m-%d %H-%M-%S.png" \
    --copy-command wl-copy \
    --initial-tool arrow \
    --early-exit \
    --actions-on-enter save-to-clipboard
