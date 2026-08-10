# Noctalia → herdr theme template

Regenerates herdr's colors from the active [Noctalia](https://noctalia.dev)
palette, so the terminal workspace manager follows the shell theme (and the
wallpaper, when the palette source is `wallpaper`).

## Why there is a hook

Most Noctalia templates drop a whole file into a themes directory. herdr has no
themes directory and no include directive — its only colour knob is a
`[theme.custom]` table inside `~/.config/herdr/config.toml`, the same file that
holds keybindings, terminal and UI settings. Overwriting that file would destroy
the rest of the config.

So the template renders a fragment to `~/.config/herdr/noctalia-theme.toml`, and
`apply.sh` splices it into `config.toml` between markers:

```toml
# >>> noctalia theme - generated, do not edit >>>
[theme.custom]
...
# <<< noctalia theme <<<
```

Properties of the merge:

- **Idempotent** — a previous generated block is replaced, not appended.
- **First run removes the hand-written `[theme.custom]`.** Two tables of the
  same name is a TOML duplicate-key error, so the old block has to go. A
  one-time snapshot is kept at `~/.config/herdr/config.toml.pre-noctalia`.
- **Appended last**, so the table runs to end-of-file and cannot swallow the
  sections that follow it.
- **Written through the path**, so a `config.toml` that symlinks into this
  dotfiles repo stays a symlink.
- **Validated** with `herdr config check`; a config that fails to parse is
  rolled back and the hook exits non-zero.
- **Reloads** the running server (`herdr server reload-config`), ignoring the
  error when nothing is running. Only the default session's server is reloaded;
  other sessions pick the colors up when they next start.
- `PATH` gains `~/.local/bin` — herdr installs itself there, and Noctalia is
  started from niri's `spawn-at-startup` without it.

## Token mapping

| herdr | Noctalia |
| ----- | -------- |
| `panel_bg` | `surface` |
| `surface_dim` | `surface_container_lowest` |
| `surface0` / `surface1` | `surface_container_low` / `surface_container` |
| `overlay0` / `overlay1` | `outline_variant` / `outline` |
| `text` / `subtext0` | `on_surface` / `on_surface_variant` |
| `accent` | `primary` |
| `red` / `peach` | `error` / `tertiary` |
| `green` `yellow` `blue` `teal` `mauve` | `terminal_normal_*` |

The ANSI-ish accents deliberately reuse the palette's terminal colors so herdr
matches kitty. Note some palettes map several roles to nearby colors — with a
warm palette, `peach` and `green` can land on the same value.

## Install

Noctalia has no user-template source; custom templates must sit in the
community-templates directory and be listed in `community_ids`. This folder is
symlinked in so the dotfiles copy stays the source of truth:

```sh
ln -sfn ~/.dotfiles/noctalia/templates/herdr \
    ~/.local/state/noctalia/community-templates/herdr
```

Then enable it — Settings → Templates, or in
`~/.local/state/noctalia/settings.toml`:

```toml
[theme.templates]
community_ids = [ "herdr", ... ]
```

Apply manually with `noctalia msg templates-apply`; Noctalia also re-runs it on
every palette or theme-mode change.

> If a Noctalia update ever prunes unknown folders from `community-templates`,
> only the symlink is lost — re-run the `ln` above.
