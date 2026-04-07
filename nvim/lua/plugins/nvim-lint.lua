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

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("nvim_lint", { clear = true }),
  callback = function()
    -- Skip linters whose binary is missing to avoid ENOENT errors
    local ft = vim.bo.filetype
    local linters = lint.linters_by_ft[ft]
    if not linters then return end
    local available = {}
    for _, name in ipairs(linters) do
      local linter = lint.linters[name]
      local cmd = type(linter) == "table" and linter.cmd or nil
      if type(cmd) == "function" then cmd = cmd() end
      if cmd and vim.fn.executable(cmd) == 1 then
        table.insert(available, name)
      end
    end
    if #available > 0 then
      lint.try_lint(available)
    end
  end,
})
