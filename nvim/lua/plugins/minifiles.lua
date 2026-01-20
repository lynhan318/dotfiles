return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = true,
    float = {
      -- Padding around the floating window
      padding = 2,
      max_width = 0,
      max_height = 0,
      -- border = "rounded",
      win_options = {
        winblend = 0,
      },
      -- preview_split = "true",
      override = function(conf)
        return conf
      end,
    },
    keymaps = {
      ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
      ["<C-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
    },
  },
  keys = { {
    "-",
    "<cmd>Oil --float --preview<cr>",
    desc = "OilTree",
    mode = "n",
  } },
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

