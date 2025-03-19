return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show { global = false }
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    "kyazdani42/nvim-web-devicons",
    lazy = true,
  },
  {
    "kylechui/nvim-surround",
    version = false,
    keys = { {
      "S",
      mode = "v",
    }, "ys", "yS", "cs", "ds" },
    config = true,
  },
  {
    "folke/trouble.nvim",
    config = true,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    "tpope/vim-fugitive",
    event = { "BufReadPre", "BufNewFile" },
    version = false,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup {}
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has "nvim-0.10.0" == 1,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
    config = function()
      local wk = require "which-key"
      local function visual_cursors_with_delay()
        -- Execute the vm-visual-cursors command.
        vim.cmd 'silent! execute "normal! \\<Plug>(VM-Visual-Cursors)"'
        -- Introduce delay via VimScript's 'sleep' (set to 500 milliseconds here).
        vim.cmd "sleep 200m"
        -- Press 'A' in normal mode after the delay.
        vim.cmd 'silent! execute "normal! A"'
      end

      wk.add {
        { "<leader>ma", "<Plug>(VM-Select-All)<Tab>", desc = "Select All", mode = "n" },
        { "<leader>mr", "<Plug>(VM-Start-Regex-Search)", desc = "Start Regex Search", mode = "n" },
        { "<leader>mp", "<Plug>(VM-Add-Cursor-At-Pos)", desc = "Add Cursor At Pos", mode = "n" },
        { "<leader>mo", "<Plug>(VM-Toggle-Mappings)", desc = "Toggle Mapping", mode = "n" },
        { "<leader>mv", visual_cursors_with_delay, desc = "Visual Cursors", mode = "v" },
      }
    end,
  },
  {
    "willothy/flatten.nvim",
    config = true,
    -- or pass configuration with
    -- opts = {  }
    -- Ensure that it runs first to minimize delay when opening file from terminal
    lazy = false,
    priority = 1001,
  },
  {
    "jparise/vim-graphql",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
}
