require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "gofmt" },
    svelte = { "prettierd", "biome" },
    typescript = { "prettierd", "biome" },
    javascript = { "prettierd", "biome" },
    json = { "prettierd", "biome" },
    rust = { "rustfmt" },
    zig = { "zigfmt" },
    ["*"] = { "prettierd" },
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
    return { timeout_ms = 1500, lsp_fallback = true }
  end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then vim.b.disable_autoformat = true else vim.g.disable_autoformat = true end
end, { bang = true })
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {})

vim.o.formatexpr = "v:lua.require('conform').formatexpr()"

vim.keymap.set("n", "<leader>p", function()
  require("conform").format({ timeout_ms = 5000, lsp_fallback = true })
end, { desc = "Format buffer" })
