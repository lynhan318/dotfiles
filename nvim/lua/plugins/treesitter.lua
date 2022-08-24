return function()
    require'nvim-treesitter.configs'.setup {
        ensure_installed = {
            "javascript", "typescript", "json", "graphql", "tsx", "html",
            "jsdoc", "rust", "css", "bash", "lua"
        },
        autotag = {enable = true},
        indent = {enable = true},
        highlight = {enable = true, use_languagetree = true},
        context_commentstring = {enable = true},
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["of"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["oc"] = "@class.outer",
                    ["ic"] = "@class.inner"
                },
                -- You can choose the select mode (default is charwise 'v')
                selection_modes = {
                    ['@parameter.outer'] = 'v', -- charwise
                    ['@function.outer'] = 'V', -- linewise
                    ['@class.outer'] = '<c-v>' -- blockwise
                },
                -- If you set this to `true` (default is `false`) then any textobject is
                -- extended to include preceding xor succeeding whitespace. Succeeding
                -- whitespace has priority in order to act similarly to eg the built-in
                -- `ap`.
                include_surrounding_whitespace = true
            }
        },
        playground = {
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false -- Whether the query persists across vim sessions
        }
    }
end
