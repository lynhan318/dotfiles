return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      javascript = { "oxlint" },
      typescript = { "oxlint" },
      typescriptreact = { "oxlint" },
      javascriptreact = { "oxlint" },
      css = { "oxlint" },
      json = { "oxlint" },
      svelte = { "eslint_d" },
      -- rust: clippy runs through rust-analyzer (`check.command = "clippy"`),
      -- a second cargo process here would fight it for the target-dir lock.
      zig = { "zlint" },
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
