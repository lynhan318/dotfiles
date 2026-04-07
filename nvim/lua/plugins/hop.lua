require("hop").setup({
  keys = "etovxqpdygfblzhckisuran",
})
vim.keymap.set("n", "f", "<cmd>HopChar1CurrentLine<cr>", { desc = "Hop Char 1" })
vim.keymap.set("n", "F", "<cmd>HopChar2<cr>", { desc = "Hop Char 2" })
