local g = vim.g

local function map(mode, lhs, rhs, opts)
    local options = {
        noremap = true,
        silent = true,
    }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
g.maplocalleader = ' '

-- Insert Mapping
map("i", "jk", "<Esc>")
map("i", "ww", "<Esc>:w<CR>")
map("i", "<C-l>", "<Right>")
map("i", "<C-h>", "<Left>")

-- Normal Mapping
map("n", "t1", ":tabn 1<CR>")
map("n", "t2", ":tabn 2<CR>")
map("n", "t3", ":tabn 3<CR>")
map("n", "<ESC><ESC>", ":nohlsearch<CR>")
map("n", "<leader>q", ":q<CR>")
map("n", ";", ":", {
    silent = false,
    nowait = true,
})
-- Reclaim S for flash.treesitter; keep substitute-global helper on <leader>S.
map("n", "<leader>S", ":%s//g<Left><Left>", {
    nowait = true,
    silent = false,
})
map("n", "D", "<cmd>lua vim.diagnostic.open_float()<CR>")
vim.keymap.set("n", "]q", "<cmd>cnext<CR>", { silent = true, desc = "Next qf entry" })
vim.keymap.set("n", "[q", "<cmd>cprev<CR>", { silent = true, desc = "Prev qf entry" })
