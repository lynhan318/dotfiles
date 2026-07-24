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
        "jake-stewart/multicursor.nvim",
        -- branch = "1.0",
        config = function()
            local mc = require("multicursor-nvim")
            mc.setup()

            local set = vim.keymap.set

            set("x", "<leader>mv", mc.visualToCursors, { desc = "MC visual → cursors" })
            set({ "n", "x" }, "<leader>ma", mc.matchAllAddCursors, { desc = "MC select all matches" })
            set({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(1) end, { desc = "MC add prev occurrence" })
            set({ "n", "x" }, "<C-x>", function() mc.matchSkipCursor(1) end, { desc = "MC skip current match" })

            set("n", "<Esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                elseif mc.hasCursors() then
                    mc.clearCursors()
                else
                    vim.cmd("nohlsearch")
                end
            end)
        end,
    },
    {
        "jparise/vim-graphql",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "otavioschwanck/arrow.nvim",
        -- Load on first bookmark keypress (its leader / buffer-leader keys)
        -- instead of eagerly at startup.
        keys = { "`", "m" },
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
