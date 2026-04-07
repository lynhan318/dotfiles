local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Insert
map("i", "jk", "<Esc>", opts)
map("i", "ww", "<Esc>:w<CR>", opts)
map("i", "<C-l>", "<Right>", opts)
map("i", "<C-h>", "<Left>", opts)

-- Window navigation (overridden by tmux-navigator when loaded)
map("n", "<c-h>", "<c-w>h", opts)
map("n", "<c-l>", "<c-w>l", opts)
map("n", "<c-j>", "<c-w>j", opts)
map("n", "<c-k>", "<c-w>k", opts)

-- Tabs
map("n", "t1", ":tabn 1<CR>", opts)
map("n", "t2", ":tabn 2<CR>", opts)
map("n", "t3", ":tabn 3<CR>", opts)

-- Misc
map("n", "<ESC><ESC>", ":nohlsearch<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", ";", ":", { noremap = true, silent = false, nowait = true })
map("n", "S", ":%s//g<Left><Left>", { noremap = true, silent = false, nowait = true })

-- IDE-style ergonomics
-- Move lines (Alt+j/k)
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
-- Keep cursor centered on jumps/scrolls
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)
-- Don't yank when pasting over selection
map("v", "p", '"_dP', opts)
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)
-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", opts)
map("n", "<S-l>", "<cmd>bnext<cr>", opts)
-- Toggle inlay hints
map("n", "<leader>ih", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })
