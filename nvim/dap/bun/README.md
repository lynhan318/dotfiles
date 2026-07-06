# nvim-dap ⟷ Bun debug adapter

nvim-dap talks DAP over stdio. Bun's debugger talks the **WebKit Inspector Protocol
over a WebSocket**. They can't talk directly, and Bun's official translation layer
(`bun-debug-adapter-protocol`) is unpublished — it only ships *inlined inside the VS Code
extension*, running in-process.

This directory bridges them:

- `packages/` — Bun's `bun-debug-adapter-protocol` + `bun-inspector-protocol`, vendored
  verbatim from the `oven-sh/bun` monorepo (they import each other by relative path, so the
  sibling `packages/` layout is preserved).
- `adapter.ts` — a tiny stdio entrypoint: a `@vscode/debugadapter` `DebugSession` whose
  inbound requests are handed to Bun's `WebSocketDebugAdapter` and whose responses/events are
  framed back to the client. Bun runs it (`bun adapter.ts`), so TypeScript + WebSocket work
  with no build step.

`nvim/lua/plugins/dap.lua` registers this as `dap.adapters.bun` and adds launch/attach
configs for `typescript`, `javascript`, `typescriptreact`, `javascriptreact`.

## Setup / reinstall

```sh
cd nvim/dap/bun
bun install        # installs @vscode/debugadapter, ws, semver, source-map-js
```

`node_modules/` is gitignored — run `bun install` after cloning your dotfiles on a new machine.

## Notable implementation detail

`adapter.ts` forces `supportsConfigurationDoneRequest: true` onto the client's `initialize`
request. Without it, Bun's adapter starts the program *during* `initialize` (before nvim-dap
registers breakpoints), so first-run breakpoints would be missed.

## Known limitation

A breakpoint placed on the file's **very first breakable line** may not bind (Bun sets an
internal line-0 sentinel breakpoint that collides with it). Put the breakpoint one line later,
or add a statement above it. Breakpoints anywhere else work normally.

## Updating to a newer Bun

Re-vendor the two packages from the tag/commit matching your `bun --revision`:

```sh
git clone --depth 1 --filter=blob:none --sparse https://github.com/oven-sh/bun.git /tmp/bun-src
cd /tmp/bun-src && git sparse-checkout set packages/bun-debug-adapter-protocol packages/bun-inspector-protocol
cp -R packages/bun-debug-adapter-protocol packages/bun-inspector-protocol <this-dir>/packages/
```

## Debugging the adapter itself

Set `BUN_DAP_TRACE=1` to log the raw inspector-protocol traffic to stderr.
