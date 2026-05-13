return {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
        jump = { autojump = true },
        modes = {
            char = { enabled = false },
            search = { enabled = false },
        },
    },
    keys = {
        {
            "f",
            mode = { "n", "x", "o" },
            function() require("flash").jump() end,
            desc = "Flash Jump",
        },
        {
            "F",
            mode = { "n", "x", "o" },
            function() require("flash").treesitter() end,
            desc = "Flash Treesitter",
        },
        {
            "r",
            mode = "o",
            function() require("flash").remote() end,
            desc = "Remote Flash",
        },
        {
            "R",
            mode = { "o", "x" },
            function() require("flash").treesitter_search() end,
            desc = "Treesitter Search",
        },
        -- {
        --     "<c-s>",
        --     mode = { "c" },
        --     function() require("flash").toggle() end,
        --     desc = "Toggle Flash Search",
        -- },
    },
}
