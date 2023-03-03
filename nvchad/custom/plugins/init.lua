return {
  ["williamboman/mason.nvim"] = {
    override_options = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "typescript-language-server",
        "css-lsp",
        "json-lsp",
        "html-lsp",
        "rust-analyzer",
        "svelte-language-server",
      },
    },
  },
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },
  ["nvim-tree/nvim-tree.lua"] = {
    override_options = {
      view = {
        adaptive_size = true,
        side = "left",
        width = 25,
        hide_root_folder = true,
        mappings = {
          -- list = {
          --   { key = "U", action = "dir_up" },
          --   { key = "C", action = "change_dir" },
          -- },
        },
      },
    },
  },
  ["tpope/vim-surround"] = {},
  ["phaazon/hop.nvim"] = {
    branch = "v2", -- optional but strongly recommended
    config = function()
      require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
    end,
  },
}
