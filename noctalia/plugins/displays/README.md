# Displays — a Noctalia plugin for niri

A macOS-style Displays panel: list every connected display, change its
resolution, refresh rate and scale, and drag the displays into the order they
sit on your desk.

Open it with `noctalia msg panel-toggle kevin/displays:panel`, from the
control-center tile, or bind it in niri:

```kdl
Mod+P hotkey-overlay-title="Displays" { spawn "noctalia" "msg" "panel-toggle" "kevin/displays:panel"; }
```

## What it does

| Feature | How |
| ------- | --- |
| List displays with live mode | `niri msg -j outputs` |
| Change resolution | `niri msg output <name> mode WxH@R`, keeping the closest refresh rate to the current one |
| Change refresh rate | the rates the panel actually reports at the current resolution — 60/120 Hz on the laptop falls out of this, with nothing hardcoded |
| Change scale | 1× – 3× |
| VRR | toggled only when the display reports `vrr_supported` |
| Reorder | drag a display; the panel repacks every output left-to-right and writes the new positions |

`noctalia.outputs()` is deliberately not used: it gives geometry and scale but
no mode list and no refresh rate, and refresh rate is half the point here.

## Why it writes a config file

niri is explicit that IPC output changes are temporary — *"If the output
configuration subsequently changes in the config file, these temporary changes
will be forgotten."* So every change is also written to a generated KDL file
(default `~/.config/niri/displays-generated.kdl`). Without it, half of this
panel would quietly undo itself on the next config reload.

**To make that file take effect, include it from your niri config:**

```kdl
include "displays-generated.kdl"
```

> **Remove any hand-written `output` blocks first.** Two blocks for the same
> output are a conflict, and the point of this plugin is that you stop
> hand-writing them.

Turn the file off entirely with the *Save changes to the niri config* setting,
if you would rather the panel only make temporary changes.

## Connector churn

Outputs are keyed by `make model serial` rather than the connector name:

```kdl
output "Xiaomi Corporation Mi Monitor 6638000003067" { … }
```

niri accepts either form. This matters because a USB-C dock or a different port
hands the same monitor a different connector — `DP-2` today, `HDMI-A-1`
yesterday — which silently breaks a config written against the connector name.
A display that reports no make/model/serial (typically the internal panel) falls
back to its connector, which is stable anyway.

## Notes

- Reordering aligns tops and packs displays edge to edge. niri rejects
  overlapping outputs, so positions are applied one at a time, in order — each
  depends on the width of the one before it.
- Panel scripts hot-reload: edit `panel.luau` and reopen the panel. Only
  `plugin.toml` changes need a Noctalia restart.
- `runAsync`'s argv form needs `plugin_api >= 24`; this plugin targets 5 and
  builds shell-quoted command strings instead, so it runs on older hosts.

## Install

```sh
ln -sfn ~/.dotfiles/noctalia/plugins/displays \
    ~/.local/state/noctalia/plugins/materialized/community/displays
```

Then add `kevin/displays` to `[plugins] enabled` in
`~/.local/state/noctalia/settings.toml` and restart Noctalia. (`noctalia msg
plugins enable` only resolves plugins that exist in a remote source catalog.)
