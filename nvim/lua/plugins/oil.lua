require("oil").setup({
  default_file_explorer = true,
  float = {
    padding = 2,
    max_width = 0,
    max_height = 0,
    win_options = { winblend = 0 },
    override = function(conf) return conf end,
  },
  keymaps = {
    ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open in vsplit" },
    ["<C-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open in split" },
  },
})
vim.keymap.set("n", "-", "<cmd>Oil --float --preview<cr>", { desc = "OilTree" })
