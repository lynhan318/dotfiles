return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  opts = {
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
        next = "<C-n>",
        prev = "<C-p>",
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
      ["*"] = false,
    },
    copilot_node_command = "node", -- Node.js version must be > 18.x
    server_opts_overrides = {},
  },
}
