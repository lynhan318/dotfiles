local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Highlight on yank
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
  group = "YankHighlight",
  callback = function()
    vim.hl.on_yank { higroup = "IncSearch", timeout = 1000 }
  end,
})
-- Don't auto commenting new lines
autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o",
})

vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { silent = true, desc = "Next qf entry" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { silent = true, desc = "Prev qf entry" })

