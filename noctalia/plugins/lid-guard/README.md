# Lid Guard — a Noctalia plugin

A bar toggle for "close the lid and nothing happens". Caffeine one layer down:
caffeine stops the session going idle, this stops the *lid* doing anything.

Click the laptop icon next to caffeine. Struck-through icon = lid behaves
normally. Solid icon = the lid is ignored.

## Two things handle the lid, and they are unrelated

**logind suspends the machine.** `HandleLidSwitch` defaults to `suspend` and
nothing in this setup overrides it (only `HandlePowerKey=ignore` is set). This
is the part the toggle controls, by holding a `handle-lid-switch` inhibitor
lock for as long as you want the lid ignored — the documented alternative to
editing `logind.conf`, and the only one that is reversible from a bar click.

**niri blanks the laptop panel** — or rather, it used to. It reads logind's
`LidClosed` property directly, so no inhibitor reaches it. That is switched off
in `niri/config.kdl` with `debug { keep-laptop-panel-on-when-lid-is-closed }`,
which has to live there rather than in a generated include because niri allows
exactly one `debug` block. In its place, `switch-events` runs
`scripts/lid-power.sh`, which drops the panel to 5% and the CPU to power-saver
on close, and puts both back on open.

So with the guard on, closing the lid does two things: the backlight drops to
5% and the CPU profile drops to power-saver. Nothing suspends, nothing blanks,
no columns reshuffle. Delete the debug
flag to get niri's blanking back — the brightness hook then costs nothing but a
flash of 5% on the way open, and can go too.

## Why a systemd unit and not a process

An inhibitor lock lives exactly as long as the process holding it, so
`lid-guard.service` is nothing but `systemd-inhibit` wrapped around
`sleep infinity`. Starting it takes the lock, stopping it drops the lock that
instant.

Keeping it in systemd rather than spawning it from the plugin buys three
things. The guard **outlives the shell** — restarting Noctalia with the lid
already shut must not quietly start suspending the machine again. There is
**one owner**, so no orphaned inhibitors accumulate behind a crash. And the
unit is the **single source of truth**: the service polls it every 5s, so
toggling from a terminal shows up on the bar, and the bar never claims a state
systemd disagrees with.

## Shape

Same split as the official screen_recorder plugin:

| Entry | Role |
| ----- | ---- |
| `service.luau` | Owns the state. Polls the unit, runs `systemctl --user start/stop`, publishes `status`, consumes `command`. |
| `widget.luau` | Bar tile. Mirrors `status`, posts `{action="toggle"}`. No logic. |
| `shortcut.luau` | Control-center tile. Same client role, so the guard works with nothing on a bar. |

Two details in there are load-bearing:

**`systemctl show`, not `is-active`.** One call answers both questions and
exits 0 either way. A unit that was never installed comes back
`LoadState=not-found`, which `is-active` reports as plain `inactive` — the same
answer it gives for an installed unit that is merely switched off. Without the
distinction the widget would sit there looking fine and silently do nothing.

**The `requestId` on every command.** `state.watch` fires on *change*, and two
identical `{action="toggle"}` tables in a row are not a change. Without the
counter, the second click of any pair is swallowed.

## Driving it from elsewhere

```sh
systemctl --user start lid-guard.service    # lid ignored
systemctl --user stop  lid-guard.service    # lid suspends again
systemctl --user is-active lid-guard.service

noctalia msg plugin kevin/lid-guard:service all toggle
```

The target really is the literal word `all` — a `[[service]]` entry has no
output surface, and `noctalia msg plugin` rejects any other target for one.
That form is what a niri bind wants:

```kdl
Mod+Shift+L hotkey-overlay-title="Toggle Lid Guard" {
    spawn "noctalia" "msg" "plugin" "kevin/lid-guard:service" "all" "toggle";
}
```

## Install

```sh
ln -sfn ~/.dotfiles/system/user-units/lid-guard.service ~/.config/systemd/user/
systemctl --user daemon-reload

ln -sfn ~/.dotfiles/noctalia/plugins/lid-guard \
        ~/.local/state/noctalia/plugins/materialized/community/lid-guard
```

Then, with the shell **stopped** — it writes its in-memory copy back over any
change made while it is running — add to `~/.local/state/noctalia/settings.toml`:

```toml
[plugins]
enabled = [ ..., "kevin/lid-guard" ]

[widget.lid_guard]
type = "kevin/lid-guard:lid-guard"
```

and put `"lid_guard"` in whichever `[bar.*]` array you want it on. Restart the
shell. `noctalia msg plugins enable` does not work for a local plugin: it
validates the id against the remote community catalogue, finds no `kevin/*`
there, and reports `ok` while doing nothing.

## Notes

**It pairs with caffeine, it does not replace it.** They inhibit different
things. Guard on, caffeine off: the lid does nothing, but the idle timer still
runs and can lock the screen while the lid is shut. Turn both on for "leave it
running, closed, untouched".

**Nothing turns this off for you.** A guarded laptop shut in a bag stays awake
and gets hot. If you would rather it expired on its own:

```sh
systemctl --user edit lid-guard.service   # [Service] RuntimeMaxSec=3600
```

The unit has no `[Install]` section on purpose — `systemctl --user enable` would
make "the lid does nothing" the permanent default with the widget never
explaining why. If that is genuinely what you want, `HandleLidSwitch=ignore` in
`logind.conf` is the honest way to say it.
