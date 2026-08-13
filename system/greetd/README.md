# greetd + Noctalia greeter

Replaces sddm as the login manager. `config.toml` here is the source of truth
for `/etc/greetd/config.toml`; /etc is root-owned so it is copied, not symlinked.

## Install

```sh
# 1. greetd comes in as a dependency of the greeter, so one package is enough.
sudo pacman -S --needed noctalia-greeter

# 2. Config.
sudo install -Dm644 ~/.dotfiles/system/greetd/config.toml /etc/greetd/config.toml

# 3. Confirm the binary is where the config says it is. If this prints a
#    different path, fix config.toml rather than the other way round.
which noctalia-greeter-session

# 4. Swap the display manager. Both in one command so there is never a boot
#    with two of them enabled, or none.
sudo systemctl disable sddm.service --now && sudo systemctl enable greetd.service

# 5. Reboot.
```

Step 4 is the only irreversible-feeling one. It is not actually irreversible:
if greetd fails to draw, switch to a text console with **Ctrl+Alt+F2**, log in,
and run

```sh
sudo systemctl disable greetd.service && sudo systemctl enable sddm.service --now
```

This works because greetd only ever claims vt 1 — every other vt stays a normal
getty.

## Notes

- The greeter keeps its state in `/var/lib/noctalia-greeter/`, created by the
  package. Session and colour-scheme choices persist in `sync.toml` there.
- Only one Wayland session is installed (`/usr/share/wayland-sessions/niri.desktop`,
  listed as **Niri**), so there is no session to pin. If a second compositor is
  ever installed and the greeter should still default to niri, add to
  `/var/lib/noctalia-greeter/greeter.toml`:

  ```toml
  [session]
  default = "Niri"
  ```

  Use the exact name from `noctalia-greeter sessions`, not the .desktop filename.
- To skip the user picker and land straight on the password prompt, add to the
  same file:

  ```toml
  [user]
  default = "kevin"
  ```

- Wallpaper and palette sync from the running Noctalia shell requires the
  `noctalia` package, which is already installed. Synced fonts must be
  system-installed — fonts that live only in `~/.local/share/fonts` will not
  resolve, because the greeter runs as the `greeter` user.
