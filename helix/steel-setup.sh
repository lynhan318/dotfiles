#!/usr/bin/env bash
# Build the Steel-enabled helix fork and install the plugins referenced by
# init.scm (from https://helix-plugins.com/).
#
# Installs `hx` + `forge` + steel-language-server into ~/.cargo/bin.
# Does NOT touch the stable /usr/bin/helix.
set -euo pipefail

SRC="$HOME/.local/src/helix-steel"
CFG="$HOME/.config/helix"

echo "==> 1/6 Fetching mattwparas/helix (steel-event-system branch)"
if [ -d "$SRC/.git" ]; then
  git -C "$SRC" pull --ff-only
else
  mkdir -p "$(dirname "$SRC")"
  git clone --branch steel-event-system https://github.com/mattwparas/helix "$SRC"
fi

echo "==> 2/6 Building hx + forge + steel-language-server (takes a while)"
cd "$SRC"
cargo xtask steel

echo "==> 3/6 Linking runtime (themes/queries) into config dir"
ln -sfn "$SRC/runtime" "$CFG/runtime"

echo "==> 4/6 Fetching + building tree-sitter grammars"
"$HOME/.cargo/bin/hx" --grammar fetch
"$HOME/.cargo/bin/hx" --grammar build

echo "==> 5/6 Vendoring keymap helper cog (used by init.scm)"
mkdir -p "$CFG/cogs"
curl -fsSL https://raw.githubusercontent.com/mattwparas/helix-config/master/cogs/keymaps.scm \
  -o "$CFG/cogs/keymaps.scm"

echo "==> 6/6 Installing plugins with forge"
FORGE="$HOME/.cargo/bin/forge"
"$FORGE" pkg install --git https://github.com/thomasschafer/scooter.hx.git        # find & replace (grug-far)
"$FORGE" pkg install --git https://github.com/Ra77a3l3-jar/oil.hx.git             # file manager (oil.nvim)
"$FORGE" pkg install --git https://github.com/gllms/streal.hx.git                 # bookmarks (arrow.nvim)
"$FORGE" pkg install --git https://github.com/mattwparas/helix-file-watcher.git   # auto-reload

echo
echo "Done. Start it with: hx"
echo "Stable helix stays at /usr/bin/helix. To make hx the default: export EDITOR=hx"
