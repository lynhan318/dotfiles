# niri + Noctalia session

A drop-in alternative to the DMS (DankMaterialShell) setup, using
[Noctalia](https://noctalia.dev) as the shell instead. It reuses your existing
niri base (inputs, workspaces, animations, window rules, outputs) and swaps the
shell-specific bits.

## Layout

Mirrors the `dms/` folder:

| DMS                 | Noctalia                  | Purpose                                  |
| ------------------- | ------------------------- | ---------------------------------------- |
| `config.kdl`        | `../config-noctalia.kdl`  | Main config + startup + layer rules      |
| `dms/binds.kdl`     | `noctalia/binds.kdl`      | Keybinds (shell IPC swapped)             |
| `dms/colors.kdl`    | `noctalia/colors.kdl`     | Border / focus-ring colors (static)      |
| `dms/layout.kdl`    | `noctalia/layout.kdl`     | Gaps, border widths, corner radius       |
| `dms/outputs.kdl`   | `noctalia/outputs.kdl`    | Monitor layout (copy — hardware-bound)   |
| `dms/cursor.kdl`    | `noctalia/cursor.kdl`     | Cursor theme                             |
| `dms/windowrules.kdl` | `noctalia/windowrules.kdl` | Noctalia window rules                  |

## Activate

### Recommended: pick the combo at the login screen

Your display manager is **SDDM**, which lists every `.desktop` in the system
session dirs (`/usr/local/share/wayland-sessions`, `/usr/share/wayland-sessions`)
in its session menu. Run the installer once to add **"niri + DMS"** and
**"niri + Noctalia"** entries:

```sh
~/.dotfiles/niri/sessions/install.sh
```

Then at login, open the SDDM session menu and choose the combo. SDDM remembers
the last one per user. See `../sessions/README.md` for how the switch works
(each entry exports `NIRI_SHELL` + `NIRI_CONFIG`; a `dms.service` drop-in skips
DMS only in the Noctalia session, so the stock "Niri" entry is unaffected). The
installer needs `sudo` to copy the entries into `/usr/local/share/wayland-sessions`
(SDDM doesn't read your home); the `dms.service` gate stays a user drop-in.

### Manual: just swap the active config

niri always loads `~/.config/niri/config.kdl`. Point that at the Noctalia
config (back up first if `config.kdl` is a real file rather than a symlink):

```sh
ln -sf ~/.dotfiles/niri/config-noctalia.kdl ~/.config/niri/config.kdl
```

With this manual route you must also stop DMS from autostarting
(`systemctl --user disable --now dms.service`), then restart niri. Validate any
time with:

```sh
niri validate -c ~/.dotfiles/niri/config-noctalia.kdl
```

Switch back to DMS: `ln -sf ~/.dotfiles/niri/config.kdl ~/.config/niri/config.kdl`
(and re-enable `dms.service`).

## Shell launch & IPC

- Launched via `spawn-at-startup "noctalia" "--daemon"`.
- This build (`noctalia-git`) uses the **`noctalia msg <command>`** IPC dialect
  (Noctalia v5), *not* the older `qs -c noctalia-shell ipc call` form.
- See everything available with `noctalia msg --help`.

## Keybind mapping (DMS → Noctalia)

| Key             | Action            | Command                                  |
| --------------- | ----------------- | ---------------------------------------- |
| `Mod+D`         | App launcher      | `noctalia msg panel-toggle launcher`     |
| `Mod+V`         | Clipboard history | `noctalia msg panel-toggle clipboard`    |
| `Mod+A`         | Control center    | `noctalia msg panel-toggle control-center` |
| `Mod+M`         | Session/power     | `noctalia msg panel-toggle session`      |
| `Mod+N`         | Notifications     | `noctalia msg panel-toggle notifications`|
| `Mod+Comma`     | Settings          | `noctalia msg settings-toggle`           |
| `Mod+Y`         | Wallpaper picker  | `noctalia msg panel-toggle wallpaper`    |
| `Mod+S`         | Region screenshot | `noctalia msg screenshot-region`         |
| `Mod+Ctrl+L`    | Lock              | `noctalia msg session lock`              |
| Volume keys     | Volume + OSD      | `noctalia msg volume-up/down/mute`       |
| Brightness keys | Brightness + OSD  | `noctalia msg brightness-up/down`        |
| Media keys      | Media transport   | `noctalia msg media toggle/next/previous`|

### Not carried over (no Noctalia equivalent)

- `Mod+P` color picker, `Mod+Shift+N` notepad, `Ctrl+Mod+Delete` process list —
  left commented in `binds.kdl`. Wire an external tool (e.g. `hyprpicker`) if wanted.

## Theming note

Unlike DMS, Noctalia does **not** auto-generate `colors.kdl`. The values there
are static Everforest. To have Noctalia drive niri's border colors from the
active wallpaper palette, add a niri template in **Noctalia Settings → Templates**
that writes `colors.kdl`, then run `noctalia msg templates-apply`.
