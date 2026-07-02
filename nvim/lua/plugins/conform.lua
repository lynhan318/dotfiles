return {
  "stevearc/conform.nvim",
  dependencies = { "mason.nvim" },
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>p",
      function()
        require("conform").format {
          timeout_ms = 5000,
          lsp_fallback = true,
        }
      end,
      desc = "Format the current buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      go = { "gofmt" },
      svelte = { "prettier", stop_after_first = true },
      typescript = { "prettierd", "biome", stop_after_first = true },
      javascript = { "prettierd", "biome", stop_after_first = true },
      json = { "prettierd", "biome", stop_after_first = true },
      rust = { "rustfmt" },
      zig = { "zigfmt" },
      ["_"] = { "prettierd" },
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
  end,
}
