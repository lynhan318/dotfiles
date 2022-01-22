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
    use {'liuchengxu/vista.vim'}
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
    -- use {'rinx/lspsaga.nvim'}

    -- use {'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons'}

    -- Surround
    use {'tpope/vim-surround'}
    use {'windwp/nvim-ts-autotag'}
    use {'jiangmiao/auto-pairs'}

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
        config = function()
            -- UltiSnips setting
            vim.g.UltiSnipsExpandTrigger = "<C-o>"
        end
    }

    -- Completion
    -- use {'hrsh7th/nvim-compe', config = require 'plugins.nvim-compe'}
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'hrsh7th/cmp-buffer'}
    use {'hrsh7th/cmp-path'}
    use {'hrsh7th/cmp-cmdline'}
    use {'hrsh7th/nvim-cmp', config = require 'plugins.nvim-compe'}
    use {'quangnguyen30192/cmp-nvim-ultisnips'}

    -- Smooth scrollw
    use {'psliwka/vim-smoothie'}
    use {'sainnhe/everforest', config = require 'plugins.theme'}

    use {'rust-lang/rust.vim'}
    -- use {'simrat39/rust-tools.nvim', config = require 'plugins.rust'}
    -- use {'mfussenegger/nvim-dap'}
    use {'nvim-lua/popup.nvim'}
    use {'nvim-lua/plenary.nvim'}
    use {'nvim-lua/lsp_extensions.nvim'}

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
    use {'mhartington/formatter.nvim', config = require 'plugins.prettier'}

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

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}},
        config = require 'plugins.telescope'
    }

    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
end)
