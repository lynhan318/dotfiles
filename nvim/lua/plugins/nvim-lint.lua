return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
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
        require("lint").try_lint()
      end,
    })
  end,
}
