# Herdr Sessions — a Noctalia plugin

Lists every herdr session in a Noctalia panel. Click one and it opens in a new
terminal window, attached.

Open it with `noctalia msg panel-toggle kevin/herdr:panel`, from the
control-center tile, from a bar widget action, or bind it in niri:

```kdl
Mod+T hotkey-overlay-title="Herdr Sessions" { spawn "noctalia" "msg" "panel-toggle" "kevin/herdr:panel"; }
```

To hang it off a `custom_button` bar widget, set the action to **Run a
command…** with:

```
noctalia msg panel-toggle kevin/herdr:panel
```

## What it does

| Feature | How |
| ------- | --- |
| List sessions with live state | `herdr session list --json` |
| Open a session | `<terminal> --class=<app_id> --title="herdr: NAME" -e herdr [--session NAME]` |
| Show which are running | the `running` field, as a tag on each row |
| Keep the default session first | sorted on `default`, then by name |

## Four things that are load-bearing

**PATH.** Noctalia is started from niri's `spawn-at-startup`, whose PATH has no
`~/.local/bin` — which is exactly where herdr installs itself. Every command the
panel runs is prefixed with `PATH="$HOME/.local/bin:$PATH"`, so a bare `herdr`
in the `herdr_path` setting resolves as well as a full path. This is also why
the manifest has no `dependencies = ["herdr"]`: that check runs against the bare
name and would disable the plugin on a machine where herdr is installed and
working perfectly.

**The default session is not addressable by name.** `herdr --session default`
creates a *new* named session under `~/.config/herdr/sessions/default`, next to
the real default at `~/.config/herdr`. Bare `herdr` is the only way to reach it,
so rows with `default: true` are spawned without the flag.

**The spawned window must not look nested.** herdr refuses to start inside an
existing session — `nested herdr is disabled by default` — and it decides that
from `HERDR_ENV`, `HERDR_SESSION`, `HERDR_SOCKET_PATH`, `HERDR_PANE_ID`,
`HERDR_TAB_ID` and `HERDR_WORKSPACE_ID`. Noctalia inherits all of those the
moment you restart the shell by hand from a herdr window, and then every session
opened from this panel dies on arrival. The spawn clears them with `env -u`.

**`ui.scroll` needs `plugin_api >= 9`.** At 5 the panel renders as a 0x0 surface
with nothing logged at all, which is a thoroughly unpleasant thing to debug.

## Settings

| Setting | Default | Purpose |
| ------- | ------- | ------- |
| `herdr_path` | `~/.local/bin/herdr` | Path to the herdr binary. `~` is expanded; a bare name works too |
| `terminal` | `ghostty` | Terminal that hosts the session |
| `app_id` | `local.maximized.herdr` | app-id given to the window |

The default `app_id` leans on the convention in `niri/config.kdl`: a prefix rule
maximizes anything under `local.maximized.*`, so sessions open full-width
without this plugin needing a window rule of its own. `local.fullscreen.herdr`
gets true fullscreen instead.

The terminal flags are ghostty's — `--key=value` (a space-separated
`--class herdr` is silently not parsed), and `-e` last. Pointing `terminal` at
something else may need `panel.luau` adjusted.

## Install

Noctalia discovers plugins from `~/.local/state/noctalia/plugins/materialized/`,
so symlink this directory in and add the id to the enabled list:

```sh
ln -sfn ~/.dotfiles/noctalia/plugins/herdr \
        ~/.local/state/noctalia/plugins/materialized/community/herdr
```

Then add `"kevin/herdr"` to `[plugins] enabled` in
`~/.local/state/noctalia/settings.toml` and restart the shell.

`noctalia msg plugins enable kevin/herdr` does **not** work for a local plugin:
it validates the id against the remote community catalogue, finds no `kevin/*`
there, and reports `ok (exporting in background)` while doing nothing. Edit the
array directly — with the shell stopped, or it will write its in-memory copy
back over the change.

Once registered, `panel.luau` is file-watched: edits are picked up on the next
open, and only `plugin.toml` changes need a restart.
