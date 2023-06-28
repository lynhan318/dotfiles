-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

vim.wo.wrap = false
vim.g.vscode_snippets_path = "./snippets.json"
-- vim.wo.foldmethod = "expr"
local opts = {}
vim.o.inccommand = "split"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
