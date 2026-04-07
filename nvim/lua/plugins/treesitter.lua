-- nvim-treesitter `main` branch: parser installer only.
-- Highlight / indent / folds are started per-buffer via FileType autocmd
-- using the built-in `vim.treesitter` API on nvim 0.11+.

local ensure_installed = {
    "vim", "vimdoc", "lua", "luadoc",
    "html", "css", "javascript", "typescript", "tsx", "svelte",
    "json", "yaml", "toml",
    "c", "rust", "go",
    "markdown", "markdown_inline",
    "bash", "regex", "diff", "gitcommit",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup()
            require("nvim-treesitter").install(ensure_installed)

            vim.treesitter.language.register("markdown", "mdx")

            local ft_to_lang = vim.treesitter.language.get_lang
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
                callback = function(ev)
                    local lang = ft_to_lang(ev.match) or ev.match
                    if not lang then return end
                    -- Only start if a parser is actually available; avoids errors
                    -- on filetypes without an installed parser.
                    local ok = pcall(vim.treesitter.start, ev.buf, lang)
                    if not ok then return end
                    -- Indent (experimental but stable enough on 0.12).
                    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    -- Folds via treesitter.
                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                end,
            })

            -- Minimal incremental selection replacement (master had this as a module).
            local function tsnode_under_cursor()
                return vim.treesitter.get_node()
            end
            vim.keymap.set("n", "<CR>", function()
                local n = tsnode_under_cursor(); if not n then return end
                local r1, c1, r2, c2 = n:range()
                vim.fn.setpos("'<", { 0, r1 + 1, c1 + 1, 0 })
                vim.fn.setpos("'>", { 0, r2 + 1, c2, 0 })
                vim.cmd("normal! gv")
            end, { desc = "TS init selection" })
            vim.keymap.set("x", "<Tab>", function()
                local n = tsnode_under_cursor(); if not n then return end
                local p = n:parent() or n
                local r1, c1, r2, c2 = p:range()
                vim.fn.setpos("'<", { 0, r1 + 1, c1 + 1, 0 })
                vim.fn.setpos("'>", { 0, r2 + 1, c2, 0 })
                vim.cmd("normal! gv")
            end, { desc = "TS expand selection" })
        end,
    },

    -- Textobjects (already on `main` branch in your old config).
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = "VeryLazy",
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"]  = "V",
                        ["@class.outer"]     = "<c-v>",
                    },
                    include_surrounding_whitespace = true,
                },
            })
            local sel = require("nvim-treesitter-textobjects.select").select_textobject
            local map = vim.keymap.set
            map({ "x", "o" }, "af", function() sel("@function.outer", "textobjects") end)
            map({ "x", "o" }, "if", function() sel("@function.inner", "textobjects") end)
            map({ "x", "o" }, "ac", function() sel("@conditional.outer", "textobjects") end)
            map({ "x", "o" }, "ic", function() sel("@conditional.inner", "textobjects") end)
            map({ "x", "o" }, "al", function() sel("@loop.outer", "textobjects") end)
            map({ "x", "o" }, "il", function() sel("@loop.inner", "textobjects") end)
            map({ "x", "o" }, "ab", function() sel("@block.outer", "textobjects") end)
            map({ "x", "o" }, "ib", function() sel("@block.inner", "textobjects") end)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        opts = {
            max_lines = 3,
            multiline_threshold = 1,
            min_window_height = 20,
        },
        keys = {
            {
                "[c",
                function()
                    if vim.wo.diff then return "[c" end
                    vim.schedule(function() require("treesitter-context").go_to_context() end)
                    return "<Ignore>"
                end,
                desc = "Jump to upper context",
                expr = true,
            },
        },
    },

    {
        "windwp/nvim-ts-autotag",
        event = "InsertEnter",
        opts = {},
    },

    -- endwise has no `main` branch yet but is a standalone plugin that
    -- attaches via its own autocmds; safe to keep.
    {
        "RRethy/nvim-treesitter-endwise",
        event = "InsertEnter",
    },
}
