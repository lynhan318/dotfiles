return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require("lint").linters_by_ft = {
          javascript = { "biomejs" },
          typescript = { "biomejs" },
          typescriptreact = { "biomejs" },
          javascriptreact = { "biomejs" },
          css = { "biomejs" },
          json = { "biomejs" },
          svelte = { "eslint_d" },
          rust = { "clippy" },
        }
        require("lint").try_lint()
      end,
    })
  end,
}
