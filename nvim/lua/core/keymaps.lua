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

-- Insert Mapping
map("i", "jk", "<Esc>")
map("i", "ww", "<Esc>:w<CR>")
map("i", "<C-l>", "<Right>")
map("i", "<C-h>", "<Left>")

-- Normal Mapping
map("n", "<c-h>", "<c-w>h")
map("n", "<c-l>", "<c-w>l")
map("n", "t1", ":tabn 1<CR>")
map("n", "t2", ":tabn 2<CR>")
map("n", "t3", ":tabn 3<CR>")
map("n", "<c-j>", "<c-w>j")
map("n", "<c-k>", "<c-w>k")
map("n", "<ESC><ESC>", ":nohlsearch<CR>")
map("n", "<leader>q", ":q<CR>")
map("n", ";", ":", {
  silent = false,
  nowait = true,
})
map("n", "S", ":%s//g<Left><Left>", {
  nowait = true,
  silent = false,
})


