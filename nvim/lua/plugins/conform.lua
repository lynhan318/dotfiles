return {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>p",
            function()
                require("conform").format {
                    timeout_ms = 5000,
                    lsp_fallback = true,
                }
            end,
            desc = "Format the current buffer",
        },
    },
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            go = { "gofmt" },
            svelte = { "biome", "prettierd" },
            typescript = { "biome", "prettierd" },
            javascript = { "biome", "prettierd" },
            json = { "biome", "prettierd" },
            rust = { "rustfmt" },
        },

        formatters = {
            prettierd = {
                require_cwd = true,
            },
            prettier = {
                require_cwd = true,
            },
            injected = {
                ignore_errors = false,
            },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
    end,
}
