local M = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    branch = "master",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-locals",
        { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
        {
            'nvim-treesitter/nvim-treesitter-context',
            opts = {
                -- Avoid the sticky context from growing a lot.
                max_lines = 3,
                -- Match the context lines to the source code.
                multiline_threshold = 1,
                -- Disable it when the window is too small.
                min_window_height = 20,
            },
            keys = {
                {
                    '[c',
                    function()
                        -- Jump to previous change when in diffview.
                        if vim.wo.diff then
                            return '[c'
                        else
                            vim.schedule(function()
                                require('treesitter-context').go_to_context()
                            end)
                            return '<Ignore>'
                        end
                    end,
                    desc = 'Jump to upper context',
                    expr = true,
                },
            },
        },
        "RRethy/nvim-treesitter-endwise",
        "windwp/nvim-ts-autotag",
    },
}

function M.config()
    local ts_config = require "nvim-treesitter.configs"
    ts_config.setup {
        ensure_installed = {
            "vim",
            "lua",
            "html",
            "css",
            "typescript",
            "svelte",
            "javascript",
            "c",
            "markdown",
            "rust",
            "markdown",
        },

        ignore_install = {}, -- List of parsers to ignore installing
        endwise = {
            enable = true,
        },
        autotag = {
            enable = true,
        },
        highlight = {
            enable = true, -- false will disable the whole extension
            disable = {},  -- list of language that will be disabled
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                scope_incremental = "<CR>",
                node_incremental = "<Tab>",
                node_decremental = "<S-Tab>",
            },
        },
        playground = {
            enable = true,
        },
        query_linter = {
            enable = true,
            use_virtual_text = true,
            lint_events = { "BufWrite", "CursorHold" },
        },
        refactor = {
            smart_rename = {
                enable = true,
                keymaps = {
                    smart_rename = "grr",
                },
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ic"] = "@conditional.inner",
                    ["ac"] = "@conditional.outer",
                    ["il"] = "@loop.inner",
                    ["al"] = "@loop.outer",
                    ["ib"] = "@block.inner",
                    ["ab"] = "@block.outer",
                },
                selection_modes = {
                    ["@parameter.outer"] = "v", -- charwise
                    ["@function.outer"] = "V",  -- linewise
                    ["@class.outer"] = "<c-v>", -- blockwise
                },
                include_surrounding_whitespace = true,
            },
        },
    }
    -- local toggle_inc_selection_group =
    --     vim.api.nvim_create_augroup('mariasolos/toggle_inc_selection', { clear = true })
    -- vim.api.nvim_create_autocmd('CmdwinEnter', {
    --     desc = 'Disable incremental selection when entering the cmdline window',
    --     group = toggle_inc_selection_group,
    --     command = 'TSBufDisable incremental_selection',
    -- })
    -- vim.api.nvim_create_autocmd('CmdwinLeave', {
    --     desc = 'Enable incremental selection when leaving the cmdline window',
    --     group = toggle_inc_selection_group,
    --     command = 'TSBufEnable incremental_selection',
    -- })
    vim.treesitter.language.register("markdown", "mdx")
end

return M
