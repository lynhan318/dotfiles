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
      rust = { "clippy" },
      zig = { "zlint" },
    }

    -- `cargo clippy` exits 1 whenever the crate has errors or denied warnings,
    -- but it still emits diagnostics as JSON on stdout. Ignore the exit code so
    -- nvim-lint stops spamming "Linter command `cargo` exited with code: 1".
    lint.linters.clippy.ignore_exitcode = true

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
