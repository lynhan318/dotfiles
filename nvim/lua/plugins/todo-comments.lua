require("todo-comments").setup({
  signs = true,
})

local map = vim.keymap.set
map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo" })
map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Prev todo" })
map("n", "<leader>st", "<cmd>TodoFzfLua<cr>", { desc = "Search TODOs" })
