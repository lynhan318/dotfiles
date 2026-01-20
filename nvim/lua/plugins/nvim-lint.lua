return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").linters_by_ft = {
          javascript = { "eslint_d" },
          typescript = { "eslint_d" },
          typescriptreact = { "eslint_d" },
          javascriptreact = { "eslint_d" },
          css = { "eslint_d" },
          json = { "eslint_d" },
          svelte = { "eslint_d" },
          rust = { "clippy" },
          zig = { "zlint" },
        }
        require("lint").try_lint()
      end,
    })
  end,
}
