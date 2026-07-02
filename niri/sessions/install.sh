#!/bin/sh
# Install the "niri + DMS" and "niri + Noctalia" session entries so they appear
# in the SDDM session menu at login.
#
# SDDM scans ONLY system session dirs (/usr/local/share/wayland-sessions and
# /usr/share/wayland-sessions) and runs its greeter as the unprivileged `sddm`
# user, which cannot read your home. So the .desktop files must be REAL files
# (not symlinks into ~/.dotfiles) in a system dir -> this needs sudo. The
# wrapper scripts they point at still run as you after login, so they can live
# in your dotfiles. The dms.service gate is a per-user systemd drop-in (no root).
set -e
SRC="$(cd "$(dirname "$0")" && pwd)"
SESSION_DIR="/usr/local/share/wayland-sessions"

echo ":: making session wrappers executable"
chmod +x "$SRC/niri-dms" "$SRC/niri-noctalia"

echo ":: installing session entries -> $SESSION_DIR (sudo)"
sudo install -Dm644 "$SRC/niri-dms.desktop"      "$SESSION_DIR/niri-dms.desktop"
sudo install -Dm644 "$SRC/niri-noctalia.desktop" "$SESSION_DIR/niri-noctalia.desktop"

# Remove stale entries from a previous (greeter-era) install that put symlinks
# in ~/.local/share/wayland-sessions, which SDDM never reads.
for legacy in niri-dms.desktop niri-noctalia.desktop; do
    rm -f "$HOME/.local/share/wayland-sessions/$legacy"
done

echo ":: installing dms.service gate -> ~/.config/systemd/user/dms.service.d"
mkdir -p "$HOME/.config/systemd/user/dms.service.d"
ln -sf "$SRC/dms.service.d/combo.conf" "$HOME/.config/systemd/user/dms.service.d/combo.conf"
systemctl --user daemon-reload

cat <<EOF

Done. At the SDDM login screen open the session menu (top-right / cog) and pick:
  - "niri + DMS"        (DankMaterialShell, same as the stock "Niri" entry)
  - "niri + Noctalia"   (Noctalia shell)

SDDM remembers the last chosen session per user. The stock "Niri" entry still
works and still uses DMS (only the Noctalia combo skips it).

Uninstall:
  sudo rm $SESSION_DIR/niri-dms.desktop $SESSION_DIR/niri-noctalia.desktop
  rm ~/.config/systemd/user/dms.service.d/combo.conf
  systemctl --user daemon-reload
EOF
