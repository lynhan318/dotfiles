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
        branch = "1.0",
        keys = {
            { "<leader>ma", desc = "Multicursor: select all matches",  mode = { "n", "x" } },
            { "<leader>mr", desc = "Multicursor: regex search → all",  mode = { "n", "x" } },
            { "<leader>mp", desc = "Multicursor: add cursor below",    mode = { "n", "x" } },
            { "<leader>mo", desc = "Multicursor: clear all cursors",   mode = { "n", "x" } },
            { "<leader>mu", desc = "Multicursor: restore last cursors", mode = { "n", "x" } },
            { "<leader>mv", desc = "Multicursor: visual → cursors",    mode = "x" },
            { "<leader>m=", desc = "Multicursor: align cursors",       mode = { "n", "x" } },
            { "<leader>mi", desc = "Multicursor: sequence ++",         mode = { "n", "x" } },
            { "<leader>mI", desc = "Multicursor: sequence --",         mode = { "n", "x" } },
            { "<C-d>",      desc = "Multicursor: add next occurrence", mode = { "n", "x" } },
            { "<C-n>",      desc = "Multicursor: add prev occurrence", mode = { "n", "x" } },
            { "<C-x>",      desc = "Multicursor: skip current match",  mode = { "n", "x" } },
        },
        config = function()
            local mc = require("multicursor-nvim")
            mc.setup()

            local set = vim.keymap.set

            set({ "n", "x" }, "<leader>ma", mc.matchAllAddCursors,    { desc = "MC select all matches" })
            set({ "n", "x" }, "<leader>mp", function() mc.lineAddCursor(1) end, { desc = "MC add cursor below" })
            set({ "n", "x" }, "<leader>mo", mc.clearCursors,          { desc = "MC clear cursors" })
            set({ "n", "x" }, "<leader>mu", mc.restoreCursors,        { desc = "MC restore last cursors" })
            set("x",          "<leader>mv", mc.visualToCursors,        { desc = "MC visual → cursors" })
            set({ "n", "x" }, "<leader>m=", mc.alignCursors,          { desc = "MC align cursors" })
            set({ "n", "x" }, "<leader>mi", mc.sequenceIncrement,     { desc = "MC sequence ++" })
            set({ "n", "x" }, "<leader>mI", mc.sequenceDecrement,     { desc = "MC sequence --" })

            set({ "n", "x" }, "<C-d>", function() mc.matchAddCursor(1)  end, { desc = "MC add next occurrence" })
            set({ "n", "x" }, "<C-n>", function() mc.matchAddCursor(-1) end, { desc = "MC add prev occurrence" })
            set({ "n", "x" }, "<C-x>", function() mc.matchSkipCursor(1) end, { desc = "MC skip current match" })

            set("n", "<Esc>", function()
                if not mc.cursorsEnabled() then mc.enableCursors()
                elseif mc.hasCursors() then mc.clearCursors()
                else vim.cmd("nohlsearch") end
            end)
        end,
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
