return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
    copilot_node_command = "node", -- Node.js version must be > 18.x
    -- copilot_model left unset: the Copilot LSP server picks its best default
    -- completion model. Pin one only after `:Copilot model list` shows valid ids.
    panel = {
      enabled = true,
      auto_refresh = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 25,
      keymap = {
        accept = "<C-w>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-q>",
      },
    },
    filetypes = {
      rs = true,
      zig = true,
      javascript = true,
      typescript = true,
      typescriptreact = true,
      javascriptreact = true,
      svelte = true,
      css = true,
      scss = true,
      json = true,
      markdown = true,
      mdx = true,
      txt = true,
      ["*"] = false,
    },
    server_opts_overrides = {},
  },
}
