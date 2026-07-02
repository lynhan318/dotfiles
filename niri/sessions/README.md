# Login session combos (niri + DMS / niri + Noctalia)

Adds two entries to the **SDDM** session menu so you can pick your shell
at login instead of editing configs:

- **niri + DMS** — DankMaterialShell (your existing setup)
- **niri + Noctalia** — the Noctalia shell

## Install

```sh
~/.dotfiles/niri/sessions/install.sh
```

Needs **sudo** for the session entries: SDDM scans only system session dirs
(`/usr/local/share/wayland-sessions`, `/usr/share/wayland-sessions`) and its
greeter runs as the unprivileged `sddm` user, which can't read your home — so
the `.desktop` files are copied (as real files, not symlinks) into
`/usr/local/share/wayland-sessions/`. The wrapper scripts they point at still
run as **you** after login, so they stay in your dotfiles. The `dms.service`
drop-in goes into `~/.config/systemd/user/dms.service.d/` (no root), then the
script runs `systemctl --user daemon-reload`.

## Files

| File                       | Installed to                                          | Role |
| -------------------------- | ----------------------------------------------------- | ---- |
| `niri-dms.desktop`         | `/usr/local/share/wayland-sessions/` (copy, sudo)     | Session list entry → runs `niri-dms` |
| `niri-noctalia.desktop`    | `/usr/local/share/wayland-sessions/` (copy, sudo)     | Session list entry → runs `niri-noctalia` |
| `niri-dms`                 | (run in place)                                        | Wrapper: `NIRI_SHELL=dms`, DMS config, `exec niri-session` |
| `niri-noctalia`            | (run in place)                                        | Wrapper: `NIRI_SHELL=noctalia`, Noctalia config, `exec niri-session` |
| `dms.service.d/combo.conf` | `~/.config/systemd/user/dms.service.d/`               | Gate: skip DMS when `NIRI_SHELL=noctalia` |

> The `.desktop` files are **copied**, not symlinked, because the `sddm` user
> can't traverse your `drwxr-x---` home. Re-run `install.sh` after editing them.

## How the switch works

1. SDDM parses each `.desktop`'s `Name=`/`Exec=` and, after you authenticate,
   runs the `Exec` as your user (it splits on spaces, so each entry points at a
   single wrapper-script path — no shell quoting).
2. The wrapper exports `NIRI_SHELL` (the selector) and `NIRI_CONFIG` (which niri
   config to load), then `exec niri-session`.
3. `niri-session` does `systemctl --user import-environment`, so `NIRI_SHELL`
   reaches the systemd `--user` manager before `niri.service` starts.
4. `niri.service` pulls `dms.service` (`WantedBy=niri.service`). The drop-in's
   `ConditionEnvironment=!NIRI_SHELL=noctalia` lets DMS start everywhere
   **except** the Noctalia combo.
5. Noctalia is launched by `config-noctalia.kdl`'s
   `spawn-at-startup "noctalia" "--daemon"` — so it only runs in its own session.

Net result: exactly one shell per session, chosen at the SDDM menu. The stock
"Niri" entry (`/usr/share/wayland-sessions/niri.desktop`) keeps using DMS,
because the gate only excludes `NIRI_SHELL=noctalia`.

Requires systemd ≥ 246 for `ConditionEnvironment` (you have 260).

## Uninstall

```sh
sudo rm /usr/local/share/wayland-sessions/niri-dms.desktop \
        /usr/local/share/wayland-sessions/niri-noctalia.desktop
rm ~/.config/systemd/user/dms.service.d/combo.conf
systemctl --user daemon-reload
```
