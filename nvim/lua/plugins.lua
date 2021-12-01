local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                install_path)
    execute 'packadd packer.nvim'
end

-- Only required if you have packer in your `opt` pack
vim.cmd('packadd packer.nvim')

-- vim.cmd [[ autocmd BufWritePost packed.lua PackerCompile ]]

return require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}

    -- Icons
    use {'ryanoasis/vim-devicons'}
    use {'majutsushi/tagbar'}
    use {
        'kyazdani42/nvim-web-devicons',
        config = require('plugins.nvim-web-devicons')
    }

    -- Colorizer
    use {
        'norcalli/nvim-colorizer.lua',
        config = require 'plugins.nvim-colorizer'
    }

    -- Comment
    use {'JoosepAlviste/nvim-ts-context-commentstring'}
    use {'tpope/vim-commentary'}

    -- Git
    use {'tpope/vim-fugitive'}

    -- LSP
    use {'neovim/nvim-lspconfig', config = require 'plugins.nvim-lspconfig'}
    use {'nvim-lua/lsp-status.nvim'}
    use {'rinx/lspsaga.nvim'}
    use {'kabouzeid/nvim-lspinstall'}
    use {'nvim-lua/lsp_extensions.nvim'}
    -- use {'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons'}
    use {
        'ojroques/nvim-lspfuzzy',
        config = require 'plugins.fzf',
        requires = {
            {'junegunn/fzf'}, {'junegunn/fzf.vim'} -- to enable preview (optional)
        }
    }

    -- Surround
    use {'tpope/vim-surround'}
    use {'windwp/nvim-ts-autotag'}
    use {'jiangmiao/auto-pairs'}
    -- Telescope
    -- use {
    --   'nvim-telescope/telescope.nvim',
    --   requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    --   config = require'plugins.telescope'
    -- }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = require 'plugins.nvim-treesitter'
    }

    -- Barbar, bufferline
    use {"romgrk/barbar.nvim", requires = "kyazdani42/nvim-web-devicons"}
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'everforest',
                    section_separators = {left = '', right = ''},
                    component_separators = {left = '', right = ''},
                    disabled_filetypes = {"defx"}
                }

            }
        end
    }
    -- Snippets
    use {
        'SirVer/ultisnips',
        requires = "honza/vim-snippets",
        config = require "plugins.vim-vsnip"
    }
    -- use {
    --     "hrsh7th/vim-vsnip",
    --     requires = "hrsh7th/vim-vsnip-integ",
    --     config = require "plugins.vim-vsnip"
    -- }

    -- Completion
    use {'hrsh7th/nvim-compe', config = require 'plugins.nvim-compe'}

    -- Smooth scrollw
    use {'psliwka/vim-smoothie'}

    -- Theme
    -- use {
    --     'MordechaiHadad/nvim-papadark',
    --     requires = {'rktjmp/lush.nvim'},
    --     config = require 'plugins.theme'
    -- }
    use {'sainnhe/everforest', config = require 'plugins.theme'}
    -- use {'sainnhe/sonokai', config = require 'plugins.theme'}

    -- use {
    --         "rktjmp/lush.nvim", 
    --         config = require'plugins.lush'
    --     }

    use {'rust-lang/rust.vim'}
    use {'mfussenegger/nvim-dap'}
    use {'nvim-lua/popup.nvim'}
    use {'nvim-lua/plenary.nvim'}

    -- Defx 
    use {'kristijanhusak/defx-icons'};
    use {'kristijanhusak/defx-git'};
    use {
        'Shougo/defx.nvim',
        requires = {{'kristijanhusak/defx-icons'}, {'kristijanhusak/defx-git'}},
        run = ':UpdateRemotePlugins'
    };
    -- EasyMotion
    use {'easymotion/vim-easymotion'}
    -- Multi cursor
    use {'terryma/vim-multiple-cursors'}
    -- airline
    -- use {'vim-airline/vim-airline'};
    -- use {'vim-airline/vim-airline-themes'};
    use {'mhartington/formatter.nvim', config = require 'plugins.prettier'}
    use {'ray-x/lsp_signature.nvim'}

    -- indent line
    -- use {
    --         'lukas-reineke/indent-blankline.nvim',
    --         branch='lua'
    --     }
    -- transparent
    use {
        'xiyaowong/nvim-transparent',
        config = function()
            require("transparent").setup({
                enable = true, -- boolean: enable transparent
                extra_groups = { -- table/string: additional groups that should be clear
                    -- In particular, when you set it to 'all', that means all avaliable groups

                    -- example of akinsho/nvim-bufferline.lua
                },
                exclude = {} -- table: groups you don't want to clear
            })
        end

    }
    use {'cespare/vim-toml', branch = "main"}
end)
