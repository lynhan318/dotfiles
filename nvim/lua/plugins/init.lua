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
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "qf",
                callback = function(args)
                    vim.keymap.set("n", "<CR>", "<CR>", { buffer = args.buf, remap = false, nowait = true })
                end,
            })
            require("quicker").setup {
                edit = {
                    enabled = true,
                    autosave = "unmodified",
                },
                highlight = {
                    treesitter = true,
                    lsp = true,
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
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
    },
    {
        "otavioschwanck/arrow.nvim",
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
        },
        opts = {
            show_icons = true,
            leader_key = "`",
            buffer_leader_key = "m",
        },
    },
}
