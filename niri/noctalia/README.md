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
| `outputs.kdl`    | Monitor layout (hardware-bound)          |
| `cursor.kdl`     | Cursor theme                             |
| `windowrules.kdl`| Noctalia + misc window rules             |

Unlike DMS, nothing here is auto-generated — these are all hand-edited.

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
