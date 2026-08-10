#!/usr/bin/env bash
# Splice the palette Noctalia just rendered into herdr's config.toml.
#
# herdr keeps its colors in [theme.custom] inside ~/.config/herdr/config.toml —
# the same file as keybindings, terminal and UI settings — and supports neither
# an include directive nor a themes directory. So the template renders a small
# fragment next to it and this hook merges that fragment in, between markers,
# leaving everything else in the file untouched.
#
# The merge is idempotent: a previous generated block is replaced, and on the
# first run any hand-written [theme.custom] table is removed (two tables of the
# same name would be a TOML duplicate-key error).
set -euo pipefail

# Noctalia is started from niri's spawn-at-startup and does not reliably have
# ~/.local/bin on PATH, which is where herdr installs itself.
export PATH="$PATH:$HOME/.local/bin"

CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
CONFIG="$CONFIG_HOME/herdr/config.toml"
FRAGMENT="$CONFIG_HOME/herdr/noctalia-theme.toml"

if [ ! -f "$FRAGMENT" ]; then
    echo "herdr template: nothing rendered at $FRAGMENT" >&2
    exit 1
fi

if [ ! -f "$CONFIG" ]; then
    echo "herdr template: no herdr config at $CONFIG, skipping" >&2
    exit 0
fi

# One-time snapshot of the config as it looked before Noctalia ever touched it.
if [ ! -f "$CONFIG.pre-noctalia" ]; then
    cp -L "$CONFIG" "$CONFIG.pre-noctalia"
fi

# Per-run copy, used to roll back if the merged file does not parse.
ROLLBACK=$(mktemp)
trap 'rm -f "$ROLLBACK"' EXIT
cp -L "$CONFIG" "$ROLLBACK"

python3 - "$CONFIG" "$FRAGMENT" <<'PY'
import pathlib
import re
import sys

BEGIN = "# >>> noctalia theme - generated, do not edit >>>"
END = "# <<< noctalia theme <<<"

config = pathlib.Path(sys.argv[1])
fragment = pathlib.Path(sys.argv[2]).read_text().strip()

# Written through the path, not replaced, so a config.toml that is a symlink
# into a dotfiles repo stays a symlink.
text = config.read_text()

# Drop the block from a previous run.
text = re.sub(
    re.escape(BEGIN) + r".*?" + re.escape(END) + r"\n?",
    "",
    text,
    flags=re.DOTALL,
)

# Drop any [theme.custom] table left outside the managed block (first run).
kept, skipping = [], False
for line in text.splitlines(keepends=True):
    header = re.match(r"\s*\[([^\]]+)\]", line)
    if header:
        name = header.group(1).strip()
        if name == "theme.custom":
            skipping = True
            continue
        if skipping and not name.startswith("theme.custom."):
            skipping = False
    if not skipping:
        kept.append(line)

# Appended last so the table runs to end-of-file and cannot swallow the
# sections that follow it.
merged = "".join(kept).rstrip("\n")
config.write_text(f"{merged}\n\n{BEGIN}\n{fragment}\n{END}\n")
PY

if ! herdr config check >/dev/null 2>&1; then
    echo "herdr template: merged config failed 'herdr config check', rolling back" >&2
    cat "$ROLLBACK" >"$CONFIG"
    exit 1
fi

# Only meaningful when a server is up; harmless otherwise.
herdr server reload-config >/dev/null 2>&1 || true
