# niri + Noctalia

[Noctalia](https://noctalia.dev) is the shell for this niri setup. It replaced
DankMaterialShell (DMS), which has been removed — `config.kdl` is the single
niri config and pulls in the files here.

## Layout

| File             | Purpose                                  |
| ---------------- | ---------------------------------------- |
| `../config.kdl`  | Main config + startup + layer rules      |
| `binds.kdl`      | Keybinds (Noctalia IPC)                  |
| `colors.kdl`     | Border / focus-ring colors (static)      |
| `layout.kdl`     | Gaps, border widths, corner radius       |
| `cursor.kdl`     | Cursor theme                             |
| `windowrules.kdl`| Noctalia + misc window rules             |

Everything in this folder is hand-edited. Two files outside it are *generated*
and must not be edited by hand:

| File                          | Written by                                    |
| ----------------------------- | --------------------------------------------- |
| `../noctalia.kdl`             | Noctalia's niri color template                |
| `../displays-generated.kdl`   | the Noctalia `kevin/displays` plugin          |

`displays-generated.kdl` is the **only** place outputs are configured. niri
resolves an output with `.iter().find()`, so the first matching block wins
outright and later ones are ignored rather than merged — a second hand-written
block for the same monitor silently shadows the generated one instead of adding
to it. That is why the old `outputs.kdl` is gone.

The built-in panel's `mode` is deliberately absent from the generated file:
`niri-refresh-rate.service` owns it and swaps 120 Hz / 60 Hz on AC state. The
plugin's `unmanaged_modes` setting (default `eDP-1`) is what keeps it out.

## Activate

`~/.config/niri` is a symlink to `~/.dotfiles/niri`, so niri already loads
`config.kdl` from here. Nothing to activate — log in via the stock **Niri**
session (`/usr/share/wayland-sessions/niri.desktop`) and Noctalia starts with
it. niri hot-reloads config changes automatically.

Validate any time with:

```sh
niri validate -c ~/.dotfiles/niri/config.kdl
```

## Shell launch & IPC

- Launched via `spawn-at-startup "noctalia" "--daemon"` in `config.kdl`.
- This build (`noctalia-git`) uses the **`noctalia msg <command>`** IPC dialect
  (Noctalia v5), *not* the older `qs -c noctalia-shell ipc call` form.
- See everything available with `noctalia msg --help`.

## Keybinds

| Key             | Action            | Command                                  |
| --------------- | ----------------- | ---------------------------------------- |
| `Mod+D`         | App launcher      | `vicinae toggle`                         |
| `Mod+Shift+D`   | Noctalia launcher | `noctalia msg panel-toggle launcher`     |
| `Mod+V`         | Clipboard history | `noctalia msg panel-toggle clipboard`    |
| `Mod+A`         | Control center    | `noctalia msg panel-toggle control-center` |
| `Mod+M`         | Session/power     | `noctalia msg panel-toggle session`      |
| `Mod+N`         | Notifications     | `noctalia msg panel-toggle notifications`|
| `Mod+Comma`     | Settings          | `noctalia msg settings-toggle`           |
| `Mod+Y`         | Wallpaper picker  | `noctalia msg panel-toggle wallpaper`    |
| `Mod+S`         | Region screenshot | `noctalia msg screenshot-region`         |
| `Mod+G`         | Screen recording  | `noctalia msg plugin .../screen_recorder`|
| `Mod+Ctrl+L`    | Lock              | `noctalia msg session lock`              |
| Volume keys     | Volume + OSD      | `noctalia msg volume-up/down/mute`       |
| Brightness keys | Brightness + OSD  | `noctalia msg brightness-up/down`        |
| Media keys      | Media transport   | `noctalia msg media toggle/next/previous`|

### Not carried over from DMS (no Noctalia equivalent)

- `Mod+P` color picker, `Mod+Shift+N` notepad, `Ctrl+Mod+Delete` process list —
  left commented in `binds.kdl`. Wire an external tool (e.g. `hyprpicker`) if wanted.

## Theming note

Noctalia does **not** auto-generate `colors.kdl`. The values there are static
Everforest. To have Noctalia drive niri's border colors from the active
wallpaper palette, add a niri template in **Noctalia Settings → Templates**
that writes `colors.kdl`, then run `noctalia msg templates-apply`.
