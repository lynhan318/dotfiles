return {

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
        "tpope/vim-fugitive",
        event = { "BufReadPre", "BufNewFile" },
        version = false,
    },
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
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
        keys = {
            { "<leader>ma", "<Plug>(VM-Select-All)<Tab>",    desc = "Select All",         mode = "n" },
            { "<leader>mr", "<Plug>(VM-Start-Regex-Search)", desc = "Start Regex Search", mode = "n" },
            { "<leader>mp", "<Plug>(VM-Add-Cursor-At-Pos)",  desc = "Add Cursor At Pos",  mode = "n" },
            { "<leader>mo", "<Plug>(VM-Toggle-Mappings)",    desc = "Toggle Mapping",     mode = "n" },
        },
    },
    {
        "jparise/vim-graphql",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "stevearc/quicker.nvim",
        event = "FileType qf",
        ---@module "quicker"
        opts = {},
        config = function()
            vim.keymap.set("n", "<c-.>", "<cmd>cnext<CR>")
            vim.keymap.set("n", "<c-,>", "<cmd>cprev<CR>")
            require("quicker").setup {
                edit = {
                    -- Enable editing the quickfix like a normal buffer
                    enabled = true,
                    -- Set to true to write buffers after applying edits.
                    -- Set to "unmodified" to only write unmodified buffers.
                    autosave = "unmodified",
                },
                highlight = {
                    -- Use treesitter highlighting
                    treesitter = true,
                    -- Use LSP semantic token highlighting
                    lsp = true,
                    -- Load the referenced buffers to apply more accurate highlights (may be slow)
                    load_buffers = false,
                },
            }
        end,
    },
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
        {
            "beauwilliams/statusline.lua",
            dependencies = {
                "nvim-lua/lsp-status.nvim",
            },
            config = function()
                require("statusline").setup {
                    match_colorscheme = true, -- Enable colorscheme inheritance (Default: false)
                    tabline = false,          -- Enable the tabline (Default: true)
                    lsp_diagnostics = true,   -- Enable Native LSP diagnostics (Default: true)
                    ale_diagnostics = false,  -- Enable ALE diagnostics (Default: false)
                }
            end,
        },
        {
            "otavioschwanck/arrow.nvim",
            dependencies = {
                { "nvim-tree/nvim-web-devicons" },
                -- or if using `mini.icons`
                -- { "echasnovski/mini.icons" },
            },
            opts = {
                show_icons = true,
                leader_key = "`",        -- Recommended to be a single key
                buffer_leader_key = "m", -- Per Buffer Mappings
            },
        },
        {
            "kdheepak/lazygit.nvim",
            lazy = true,
            cmd = {
                "LazyGit",
                "LazyGitConfig",
                "LazyGitCurrentFile",
                "LazyGitFilter",
                "LazyGitFilterCurrentFile",
            },
            -- optional for floating window border decoration
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
            -- setting the keybinding for LazyGit with 'keys' is recommended in
            -- order to load the plugin when the command is run for the first time
            keys = {
                { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
            },
        },
    },
    -- {
    --     'andymass/vim-matchup',
    --     config = function()
    --         -- may set any options here
    --         vim.g.matchup_matchparen_offscreen = { method = "popup" }
    --     end
    -- }
}
