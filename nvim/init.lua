-- Neovim 0.12+ config — native vim.pack + native LSP
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require "core.options"
require "core.autocmds"
require "core.keymaps"

-- ============================================================================
-- Build hooks (must be registered BEFORE vim.pack.add)
-- ============================================================================
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind
    if kind ~= "install" and kind ~= "update" then return end

    if name == "nvim-treesitter" then
      pcall(function()
        vim.cmd "TSUpdate"
      end)
    elseif name == "avante.nvim" then
      vim.system({ "make" }, { cwd = ev.data.path }):wait()
    elseif name == "LuaSnip" then
      vim.system({ "make", "install_jsregexp" }, { cwd = ev.data.path }):wait()
    end
  end,
})

-- ============================================================================
-- Plugins
-- ============================================================================
local gh = function(repo) return "https://github.com/" .. repo end

vim.pack.add({
  -- Colorscheme (priority load)
  { src = gh "neanias/everforest-nvim" },

  -- Core deps
  { src = gh "nvim-lua/plenary.nvim" },
  { src = gh "nvim-tree/nvim-web-devicons" },
  { src = gh "MunifTanjim/nui.nvim" },

  -- Treesitter
  { src = gh "nvim-treesitter/nvim-treesitter", version = "master" },
  { src = gh "nvim-treesitter/nvim-treesitter-textobjects" },
  { src = gh "nvim-treesitter/nvim-treesitter-context" },
  { src = gh "RRethy/nvim-treesitter-endwise" },
  { src = gh "windwp/nvim-ts-autotag" },

  -- LSP (config defaults; we use vim.lsp.config / vim.lsp.enable)
  { src = gh "neovim/nvim-lspconfig" },
  { src = gh "b0o/SchemaStore.nvim" },
  { src = gh "SmiteshP/nvim-navic" },

  -- Completion
  { src = gh "saghen/blink.cmp", version = vim.version.range "1.*" },
  { src = gh "rafamadriz/friendly-snippets" },
  { src = gh "L3MON4D3/LuaSnip" },
  { src = gh "danymat/neogen" },

  -- Format / Lint
  { src = gh "stevearc/conform.nvim" },
  { src = gh "mfussenegger/nvim-lint" },

  -- Editing
  { src = gh "kylechui/nvim-surround" },
  { src = gh "windwp/nvim-autopairs" },
  { src = gh "folke/ts-comments.nvim" },
  { src = gh "mg979/vim-visual-multi" },
  { src = gh "stevearc/quicker.nvim" },
  { src = gh "kevinhwang91/nvim-ufo" },
  { src = gh "kevinhwang91/promise-async" },
  { src = gh "lukas-reineke/indent-blankline.nvim" },
  { src = gh "NvChad/nvim-colorizer.lua" },
  { src = gh "MagicDuck/grug-far.nvim" },

  -- Navigation
  { src = gh "ibhagwan/fzf-lua" },
  { src = gh "smoka7/hop.nvim" },
  { src = gh "stevearc/oil.nvim" },
  { src = gh "rmagatti/goto-preview" },
  { src = gh "rmagatti/logger.nvim" },

  -- Git
  { src = gh "tpope/vim-fugitive" },
  { src = gh "kdheepak/lazygit.nvim" },

  -- AI
  { src = gh "zbirenbaum/copilot.lua" },
  { src = gh "yetone/avante.nvim" },
  { src = gh "stevearc/dressing.nvim" },
  { src = gh "HakonHarnes/img-clip.nvim" },
  { src = gh "MeanderingProgrammer/render-markdown.nvim" },

  -- UI
  { src = gh "akinsho/bufferline.nvim" },
  { src = gh "nvim-lualine/lualine.nvim" },
  { src = gh "folke/which-key.nvim" },
  { src = gh "j-hui/fidget.nvim" },
  { src = gh "folke/trouble.nvim" },
  { src = gh "folke/todo-comments.nvim" },
  { src = gh "lewis6991/gitsigns.nvim" },

  -- Misc
  { src = gh "christoomey/vim-tmux-navigator" },
  { src = gh "jparise/vim-graphql" },
})

-- ============================================================================
-- Plugin setups (order: theme first)
-- ============================================================================
local function safe_require(mod)
  local ok, err = pcall(require, mod)
  if not ok then
    vim.notify("Failed to load " .. mod .. ": " .. err, vim.log.levels.WARN)
  end
end

safe_require "plugins.theme"
safe_require "plugins.treesitter"
safe_require "plugins.bufferline"
safe_require "plugins.lualine"
safe_require "plugins.which-key"
safe_require "plugins.fidget"
safe_require "plugins.trouble"
safe_require "plugins.todo-comments"
safe_require "plugins.gitsigns"
safe_require "plugins.indent-blankline"
safe_require "plugins.nvim-surround"
safe_require "plugins.autopairs"
safe_require "plugins.colorizer"
safe_require "plugins.ts-comments"
safe_require "plugins.visual-multi"
safe_require "plugins.quicker"
safe_require "plugins.ufo"
safe_require "plugins.fzf"
safe_require "plugins.hop"
safe_require "plugins.oil"
safe_require "plugins.preview"
safe_require "plugins.lazygit"
safe_require "plugins.grug-far"
safe_require "plugins.luasnip"
safe_require "plugins.blink"
safe_require "plugins.conform"
safe_require "plugins.nvim-lint"
safe_require "plugins.copilot"
safe_require "plugins.avante"
safe_require "plugins.tmux"
safe_require "plugins.lsp"
