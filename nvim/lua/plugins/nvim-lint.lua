return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("lint").linters_by_ft = {
      javascript = { "oxlint" },
      typescript = { "oxlint" },
      typescriptreact = { "oxlint" },
      javascriptreact = { "oxlint" },
      css = { "oxlint" },
      json = { "oxlint" },
      svelte = { "eslint_d" },
      rust = { "clippy" },
      zig = { "zlint" },
    }
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
