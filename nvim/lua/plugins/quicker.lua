require("quicker").setup({
  edit = {
    enabled = true,
    autosave = "unmodified",
  },
  highlight = {
    treesitter = true,
    lsp = true,
    load_buffers = false,
  },
})
vim.keymap.set("n", "<c-.>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<c-,>", "<cmd>cprev<CR>")
