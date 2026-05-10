return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        bigfile = {},
        dashboard = {},
        picker = {
            layout = {
                preset = "ivy",
                preview = true,
            },
            sources = {
                explorer = {
                    auto_close = true,
                    layout = {
                        preset = "ivy",
                        preview = true,
                    },
                },
            },
        },
        zen = {},
        image = {},
        indent = {
            animate = { enabled = false }
        },
        statuscolumn = {},
        words = { enabled = true },
        explorer = {
            replace_netrw = true,
        },
    },
    keys = {
        { "<leader>z", function() Snacks.zen() end,                     desc = "Toggle Zen Mode" },
        { "<leader>Z", function() Snacks.zen.zoom() end,                desc = "Toggle Zoom" },

        { "gd",        function() Snacks.picker.lsp_definitions() end,  desc = "Goto Definition" },
        { "gD",        function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
        { "gh",        function() Snacks.picker.lsp_declarations() end, desc = "HSplit And Goto Declaration" },
        {
            "gs",
            function()
                vim.cmd("split")
                vim.lsp.buf.definition()
            end,
            desc = "HSplit and Goto Definition"
        },
        {
            "gv",
            function()
                vim.cmd("vsplit")
                vim.lsp.buf.definition()
            end,
            desc = "VSplit and Goto Definition"
        },
        { "gr",         function() Snacks.picker.lsp_references() end,        nowait = true,                     desc = "References" },
        { "gI",         function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
        { "gy",         function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
        { "gai",        function() Snacks.picker.lsp_incoming_calls() end,    desc = "C[a]lls Incoming" },
        { "gao",        function() Snacks.picker.lsp_outgoing_calls() end,    desc = "C[a]lls Outgoing" },
        { "<leader>ss", function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
        { "rf",         function(opts) vim.lsp.buf.rename(opts) end,          nowait = true,                     desc = "Rename symbol" },
        { "K",          function(opts) vim.lsp.buf.hover(opts) end,           nowait = true,                     desc = "Hover document" },
        { "<leader>ca", function(opts) vim.lsp.buf.code_action(opts) end,     desc = "LSP Code Action" },
        { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
        { "<leader>bd", function() Snacks.bufdelete() end,                    desc = "Delete Buffer" },
        { "<leader>sd", function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
        { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,    desc = "Buffer Diagnostics" },

        { "<c-p>",      function() Snacks.picker.smart() end,                 desc = "Smart Find Files" },
        { "<c-b>",      function() Snacks.picker.buffers() end,               desc = "Buffers" },
        { "<c-g>",      function() Snacks.picker.grep() end,                  desc = "Grep" },
        { "<c-s>",      function() Snacks.picker.grep_word() end,             desc = "Visual selection or word", mode = { "n", "x" } },
        { "<c-q>",      function() Snacks.picker.qflist() end,                desc = "Quickfix List" },
        { "<leader>e",  function(opts) Snacks.explorer.open(opts) end,        desc = "Reveal File Explorer" },
        { "<leader>lg", function() Snacks.lazygit() end,                      desc = "LazyGit" },
    },
}
