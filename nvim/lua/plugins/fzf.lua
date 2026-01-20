return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",
  config = function()
    require("fzf-lua").setup {
      "ivy",
      keymap = {
        fzf = {
          ["ctrl-q"] = "select-all+accept",
        },
      },
    }
  end,
  keys = {
    {
      "<C-b>",
      "<cmd>FzfLua buffers<cr>",
      desc = "Find recent buffers",
    },
    {
      "<C-p>",
      "<cmd>FzfLua files<cr>",
      desc = "Find files in dir",
    },
    {
      "<C-s>",
      "<cmd>FzfLua grep_cword<cr>",
      desc = "Searches for the word under the cursor",
    },
    {
      "<C-g>",
      "<cmd>FzfLua live_grep<cr>",
      desc = "Grep through the project dir",
    },
    {
      "<C-t>",
      "<cmd>FzfLua lsp_document_diagnostics<cr>",
      desc = "Diagnostics Buffer",
    },
    {
      "<leader>sw",
      "<cmd>FzfLua lsp_live_workspace_symbols<cr>",
      desc = "Search document symbol",
    },
    {
      "<leader>fs",
      "<cmd>FzfLua lsp_document_symbols<cr>",
      desc = "Search document symbol",
    },
    {
      "<leader>gd",
      "<cmd>FzfLua git_diff<cr>",
      desc = "Git Diff",
    },
    {
      "<leader>gs",
      "<cmd>FzfLua git_status<cr>",
      desc = "Git status",
    },
    {
      "<C-q>",
      "<cmd>FzfLua quickfix<cr>",
      desc = "Search through jumplist",
    },
  },
}
