return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  version = "*",
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept, C-n/C-p for up/down)
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys for up/down)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-e: Hide menu
    -- C-k: Toggle signature help
    --

    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = { preset = "default" },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    -- sources = {
    --   default = { "lsp", "path", "snippets", "buffer" },
    -- },
    signature = { enabled = true },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
