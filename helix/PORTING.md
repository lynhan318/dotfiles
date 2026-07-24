# Neovim → Helix port

Two layers:

- **`config.toml` / `languages.toml`** — work on stable `/usr/bin/helix` (25.07+) today.
- **`init.scm` + plugins** — need the Steel build: run `./steel-setup.sh` once
  (builds `hx` into `~/.cargo/bin`, installs `forge` + plugins from
  [helix-plugins.com](https://helix-plugins.com/)). Stable helix ignores `.scm` files.

## Plugin equivalents

| Neovim plugin | Helix equivalent | Keys |
|---|---|---|
| snacks.picker (files/buffers/grep) | built-in pickers | `C-p` files · `C-b` buffers · `C-g` grep (also `<space>f/b//`) |
| oil.nvim | **oil.hx** (steel) | `-` opens; `:oil-*` commands; toggle hidden with `:oil-toggle-hidden` |
| grug-far.nvim | **scooter.hx** (steel) | `<space>cg` |
| arrow.nvim | **streal.hx** (steel) | `` ` `` popup: `s` toggle, `1-9` jump, `h/v` splits |
| oil `watch_for_changes` | **helix-file-watcher** (steel) | automatic |
| flash.nvim `f`/`F` | built-in `gw` (word jump labels) / `%s<regex>` | `gw` |
| nvim-surround `ys/cs/ds` | built-in match mode | `ms` add · `mr` replace · `md` delete |
| multicursor.nvim `<leader>ma` | built-in: select scope then `s<regex>` (e.g. `%s<word>`) | `s` in select · `C` copy cursor down |
| treesitter textobjects `af/if` | built-in | `maf`/`mif` function, `mat`/`mit` type, `maa`/`mia` arg, `]f` `[f` next/prev |
| incremental selection `<CR>/<Tab>` | built-in | `A-o` expand · `A-i` shrink |
| nvim-dap + dapui (bun adapter) | built-in DAP, same `adapter.ts` | `<space>G` debug menu |
| conform.nvim | `languages.toml` formatters (prettierd) + `auto-format` | `<space>cf` manual |
| nvim-lint (clippy) | rust-analyzer `check.command = "clippy"` | on save |
| blink.cmp | built-in LSP completion | `C-n/C-p`, `C-space` |
| bufferline | `bufferline = "multiple"` | `gn`/`gp` cycle buffers |
| lazygit (snacks) | tty trick | `<space>lg` |
| nvim-colorizer | `display-color-swatches` | automatic |
| nvim-autopairs | `auto-pairs = true` | automatic |
| everforest theme | `everforest_dark` built-in | — |
| vim-fugitive | `<space>g` changed-files picker + lazygit | — |
| ts-comments | built-in | `C-c` or `<space>cc` |

## Kept nvim muscle memory

`jk` escape · `ww` save · `K` hover · `<space>ca` code action · `<space>q` quit ·
`<space>bd` delete buffer · `gs`/`gv` goto-definition in split · `<space>ll`
toggle inlay hints · `H`/`L` line start/end · `C-h/j/k/l` window nav ·
`C-v`/`C-s` splits · `C-e` yazi.

## Not portable (no Helix equivalent yet)

- **nvim-ufo folding** — Helix has no code folding.
- **copilot.lua ghost text** — no inline AI suggestions; nearest is `helix-gpt`
  as an LSP completion source (commented block in `languages.toml`).
- **goto-preview floating windows** — pickers preview instead (`gr` shows previews).
- **treesitter-context** — `sticky-context` PR not merged; commented in config.
- **zen mode, dashboard, statuscolumn** — no equivalents.
- **LuaSnip custom snippets** — LSP snippets only.
- **`t1/t2/t3` tab jumps** — no goto-nth-buffer; use `gn`/`gp` or streal `1-9`.
