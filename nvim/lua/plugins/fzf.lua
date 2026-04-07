require("fzf-lua").setup({
  "ivy",
  keymap = {
    fzf = {
      ["ctrl-q"] = "select-all+accept",
    },
  },
})

local map = vim.keymap.set
map("n", "<C-b>", "<cmd>FzfLua buffers<cr>", { desc = "Find recent buffers" })
map("n", "<C-p>", "<cmd>FzfLua files<cr>", { desc = "Find files in dir" })
map("n", "<C-s>", "<cmd>FzfLua grep_cword<cr>", { desc = "Search word under cursor" })
map("n", "<C-g>", "<cmd>FzfLua live_grep<cr>", { desc = "Grep project dir" })
map("n", "<C-t>", "<cmd>FzfLua lsp_document_diagnostics<cr>", { desc = "Diagnostics buffer" })
map("n", "<leader>sw", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", { desc = "Workspace symbols" })
map("n", "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Document symbols" })
map("n", "<leader>gd", "<cmd>FzfLua git_diff<cr>", { desc = "Git diff" })
map("n", "<leader>gs", "<cmd>FzfLua git_status<cr>", { desc = "Git status" })
map("n", "<C-q>", "<cmd>FzfLua quickfix<cr>", { desc = "Quickfix" })
