-- vim-tmux-navigator: plugin auto-loads; just bind keys
local map = vim.keymap.set
map("n", "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { silent = true })
map("n", "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { silent = true })
map("n", "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { silent = true })
map("n", "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { silent = true })
map("n", "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", { silent = true })
