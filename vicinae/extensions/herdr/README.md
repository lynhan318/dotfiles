# Herdr — Vicinae extension

Browse Herdr sessions from [Vicinae](https://vicinae.com) and open them in ghostty.

### `Search Herdr Sessions` (`@kevin/herdr:herdr-sessions`)

Lists every session with its directory and a `running`/`stopped` tag.

- **Primary action:** `Open in ghostty` — spawns `ghostty --class=com.herdr.Herdr --title="herdr: NAME" -e herdr [--session NAME]`
- `⌘N` New Session (pushes the form below), copy name / attach command / directory, reload.

### `New Herdr Session` (`@kevin/herdr:herdr-new-session`)

A form that names a session and opens it.

- **Name** — validated: non-empty, `[A-Za-z0-9][A-Za-z0-9._-]*`, not already taken,
  and not `default` (that name would create a second session shadowing the real one).
- **Working Directory** — optional; passed to ghostty as `--working-directory`,
  so the session's panes start there. herdr itself has no cwd flag.

`herdr --session NAME` both creates and attaches, so "new" and "open" are the
same call — no separate create step exists in the herdr CLI.

## How it works

Sessions come from `herdr session list --json`:

```json
{"sessions":[{"default":true,"name":"default","running":false,
              "session_dir":"/home/kevin/.config/herdr",
              "socket_path":"/home/kevin/.config/herdr/herdr.sock"}]}
```

Two details worth knowing:

- **The default session is opened with bare `herdr`, not `herdr --session default`.**
  The latter would create a *new* named session under
  `~/.config/herdr/sessions/default`, separate from the real default at
  `~/.config/herdr`. Only sessions with `default: false` get `--session <name>`.
- **PATH is patched with `~/.local/bin`.** herdr installs itself there, but the
  Vicinae server is started from niri's `spawn-at-startup` and does not reliably
  have it on PATH. Both the listing call and the spawned terminal get the fix.

The ghostty window is spawned with `--class=com.herdr.Herdr`, so niri window
rules can target it by app-id. The reverse-DNS form is required, not stylistic:
ghostty hands `class` straight to GTK, which rejects a bare `herdr` with
`invalid 'class' in config, ignoring` and then falls back to ghostty's normal
app-id — silently, so a window rule matching `herdr` would simply never fire.
Ghostty also wants `--key=value`; space-separated flags are not parsed.

## Preferences

| Preference | Default | Purpose |
| ---------- | ------- | ------- |
| `herdrPath` | `herdr` | Path to the herdr binary, or a bare name to resolve on PATH |
| `terminal`  | `ghostty` | Terminal to host the session; invoked as `<terminal> -e herdr ...`. The remaining flags are ghostty-specific, so pointing this at another terminal also needs `src/lib/herdr.ts` adjusted |

## Build & install

`vici` ships inside `@vicinae/api`, so no separate CLI package is needed.

```sh
cd ~/.dotfiles/vicinae/extensions/herdr
npm install
npx vici build        # outputs straight to ~/.local/share/vicinae/extensions/herdr
```

**A newly added extension only appears after the Vicinae server restarts** —
there is no reload command, and `vicinae server` does not replace a running
instance. Restart it with:

```sh
pkill vicinae-server && setsid vicinae server &
```

Rebuilds of an already-registered extension are picked up on the next command
launch; only manifest changes need the restart.

Iterate with live reload instead via `npx vici develop`.
