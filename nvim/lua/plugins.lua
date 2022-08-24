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
    use {'kyazdani42/nvim-web-devicons', config = require('plugins.devicons')}

    -- Colorizer
    use {'norcalli/nvim-colorizer.lua', config = require 'plugins.colorizer'}

    -- Comment
    use {'JoosepAlviste/nvim-ts-context-commentstring'}
    use {'tpope/vim-commentary'}

    -- Git
    use {'tpope/vim-fugitive'}

    -- use {'rinx/lspsaga.nvim'}

    -- use {'folke/trouble.nvim', requires = 'kyazdani42/nvim-web-devicons'}

    -- Surround
    use {'tpope/vim-surround'}
    use {'windwp/nvim-ts-autotag'}
    use {'jiangmiao/auto-pairs'}

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter-textobjects'}
    use {
        'nvim-treesitter/nvim-treesitter',
        requires = "nvim-treesitter/nvim-treesitter-textobjects",
        run = ':TSUpdate',
        config = require 'plugins.treesitter'
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
                    disabled_filetypes = {"neo-tree"}
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
    -- use {'hrsh7th/nvim-compe', config = require 'plugins.compe'}
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'hrsh7th/cmp-buffer'}
    use {'hrsh7th/cmp-path'}
    use {'hrsh7th/cmp-cmdline'}
    use {'hrsh7th/cmp-nvim-lsp-signature-help'}
    use {'hrsh7th/nvim-cmp', config = require 'plugins.cmp'}
    use {'quangnguyen30192/cmp-nvim-ultisnips'}

    -- Smooth scrollw
    use {'psliwka/vim-smoothie'}
    use {'sainnhe/everforest', config = require 'plugins.theme'}

    use {'simrat39/rust-tools.nvim'}
    use {'rust-lang/rust.vim'}
    -- LSP
    use {
        'neovim/nvim-lspconfig',
        require = {{'rust-tools'}},
        config = require 'plugins.lspconfig'
    }
    use {
        'saecki/crates.nvim',
        tag = 'v0.1.0',
        requires = {'nvim-lua/plenary.nvim'},
        config = function() require('crates').setup() end
    }
    -- use {'mfussenegger/nvim-dap'}
    use {'nvim-lua/popup.nvim'}
    use {'nvim-lua/plenary.nvim'}

    -- EasyMotion
    -- use {'easymotion/vim-easymotion'}
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
    use {'othree/html5.vim'}
    use {'posva/vim-vue'}
    use {
        'evanleck/vim-svelte',
        config = function() vim.g.svelte_preprocessors = "typescript"; end
    }
    -- key binding ulti
    -- use { 'anuvyklack/hydra.nvim',config = function()
    --     local Hydra = require('hydra')
    -- end}
    use {
        'mrjones2014/smart-splits.nvim',
        config = function()
            vim.keymap.set('n', '<S-h>', require('smart-splits').resize_left)
            -- vim.keymap.set('n', '<S-j>', require('smart-splits').resize_down)
            -- vim.keymap.set('n', '<S-k>', require('smart-splits').resize_up)
            vim.keymap.set('n', '<S-l>', require('smart-splits').resize_right)
        end
    }
    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim", {
                -- only needed if you want to use the commands with "_with_window_picker" suffix
                's1n7ax/nvim-window-picker',
                tag = "1.*",
                config = function()
                    require'window-picker'.setup({
                        autoselect_one = true,
                        include_current = false,
                        filter_rules = {
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = {
                                    'neo-tree', "neo-tree-popup", "notify",
                                    "quickfix"
                                },

                                -- if the buffer type is one of following, the window will be ignored
                                buftype = {'terminal'}
                            }
                        },
                        other_win_hl_color = '#f3a14e'
                    })
                end
            }
        },
        config = require('plugins.neotree')
    }
    use {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require'hop'.setup {keys = 'etovxqpdygfblzhckisuran'}
            vim.keymap.set('n', 'fw', '<cmd>:HopChar2<cr>')
            vim.keymap.set('n', 'fl', '<cmd>:HopLine<cr>')
            vim.keymap.set('n', 'fe', '<cmd>:HopPattern<cr>')

        end
    }
    use {
        'chentoast/marks.nvim',
        config = function() require'marks'.setup {} end
    }
    use {
        'voldikss/vim-floaterm',
        config = function()
            -- vim.g.floaterm_keymap_new = '<Leader>n'
            -- vim.g.floaterm_keymap_hide = '<Leader>m'
            vim.g.floaterm_wintype = 'float'
            vim.g.floaterm_position = 'bottomright'
            vim.g.floaterm_width = 0.6
            vim.g.floaterm_height = 0.5
            vim.g.floaterm_keymap_toggle = '<C-\\>'

        end
    }
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = require('plugins.saga')
    })
    -- install fzf
    use {'junegunn/fzf'}
    use {'junegunn/fzf.vim', config = require('plugins.fzf')}
    -- use {'camspiers/animate.vim'
    -- use {'camspiers/lens.vim'}
    -- use {'ggandor/lightspeed.nvim'}
    -- use {'lukas-reineke/indent-blankline.nvim'}
    -- use {'glepnir/dashboard-nvim'}
    -- use {'liuchengxu/vim-clap'}
end)
