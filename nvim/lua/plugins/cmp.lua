return function()
    local cmp = require 'cmp'
    local lsp_symbols = {
        Text = "   (Text) ",
        Method = "   (Method)",
        Function = "   (Function)",
        Constructor = "   (Constructor)",
        Field = " ﴲ  (Field)",
        Variable = "[] (Variable)",
        Class = "   (Class)",
        Interface = " ﰮ  (Interface)",
        Module = "   (Module)",
        Property = " 襁 (Property)",
        Unit = "   (Unit)",
        Value = "   (Value)",
        Enum = " 練 (Enum)",
        Keyword = "   (Keyword)",
        Snippet = "   (Snippet)",
        Color = "   (Color)",
        File = "   (File)",
        Reference = "   (Reference)",
        Folder = "   (Folder)",
        EnumMember = "   (EnumMember)",
        Constant = " ﲀ  (Constant)",
        Struct = " ﳤ  (Struct)",
        Event = "   (Event)",
        Operator = "   (Operator)",
        TypeParameter = "   (TypeParameter)"
    }
    cmp.setup({
        sources = {
            {name = "nvim_lsp"}, {name = "path"}, {name = "buffer"},
            {name = "ultisnips"}, {name = "crates"},
            {name = 'nvim_lsp_signature_help'}
        },
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
            end
        },
        mapping = {
            ["<cr>"] = cmp.mapping.confirm({select = true}),
            ["<s-tab>"] = cmp.mapping.select_prev_item(),
            ["<tab>"] = cmp.mapping.select_next_item()
        },
        formatting = {
            format = function(entry, item)
                item.kind = lsp_symbols[item.kind]
                item.menu = ({
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    ultisnips = "[Snippet]",
                    nvim_lua = "[Lua]",
                    path = "[Path]"
                })[entry.source.name]

                return item
            end
        }
    })

end
