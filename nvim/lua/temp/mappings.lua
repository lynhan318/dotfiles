-- Better nav for omnicomplete
-- inoremap <expr> <c-j> ("\<C-n>")
-- inoremap <expr> <c-k> ("\<C-p>")
-- vim.api.nvim_set_keymap("i", "<C-Space>", "[compe#complete()]", {expr = true, silent = true})
-- vim.api.nvim_set_keymap('i', '<c-j>', '[\<C-n>]', { exp = true})
-- vim.api.nvim_set_keymap('i', '<c-k>', '["\<C-p>]', { exp = true})

-- Use shift + arrow to resize windows
vim.api.nvim_set_keymap('n', '<S-Up>', '<M-j> :resize -5<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Down>', '<M-k> :resize +5<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Left>', '<M-h> :vertical resize -5<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Right>', '<M-l> :vertical resize +5<CR>', { noremap = true })

-- ESC with kj or jk
vim.api.nvim_set_keymap('i', 'kj', '<esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'jk', '<esc>', { noremap = true, silent = true })

-- Easy CAPS
-- vim.api.nvim_set_keymap('i', '<Leader>u', '<esc>viwUi', { noremap = true })
-- vim.api.nvim_set_keymap('i', '<Leader>l', '<esc>viwu', { noremap = true })

-- Select all
vim.api.nvim_set_keymap('n', '<Leader>a', 'ggVG', { noremap = true })
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true})

-- Close all buffers
vim.api.nvim_set_keymap('n', '<C-w><C-k>', ':bufdo :bd<CR>', { noremap = true })
-- Close current buffer
vim.api.nvim_set_keymap('n', '<C-w>', ':bd<CR>', { noremap = true })

-- Toggle relative line number
-- vim.api.nvim_set_keymap('n', '<C-L><C-L>', ':set invrelativenumber<CR>', { noremap = true })

-- Ctrl-s to save
vim.api.nvim_set_keymap('n', '<C-s>', ':w!<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', 'ww', '<ESC>:w!<CR>', { noremap = true })

-- Tabbing
vim.cmd([[vnoremap < <gv]])
vim.cmd([[vnoremap > >gv]])

-- Window navigation
vim.api.nvim_set_keymap('n', '<C-h>', ':wincmd h<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd j<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd k<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':wincmd l<CR>', { noremap = true })

-- Clean highlight search
vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohlsearch<CR>', { noremap = true })

-- Replace
vim.api.nvim_set_keymap('n', '<S>', ':%s//g<Left><Left>', { noremap = true })

-- Move selected line / block of text in visual mode
vim.cmd([[xnoremap K :move '<-2<CR>gv-gv]])
vim.cmd([[xnoremap J :move '>+1<CR>gv-gv]])
