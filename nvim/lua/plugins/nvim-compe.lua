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
            {name = "nvim_lsp"}, {name = "ultisnips"}, {name = "path"},
            {name = "buffer"}
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
                    ultisnips = "[Snippet]"
                })[entry.source.name]

                return item
            end
        }
    })

    -- Setup lspconfig.
    -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
    --                                                                      .protocol
    --                                                                      .make_client_capabilities())
    -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
    -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    --     capabilities = capabilities
    -- }
    -- require'compe'.setup {
    --     enabled = true,
    --     autocomplete = true,
    --     debug = false,
    --     min_length = 1,
    --     preselect = 'enable',
    --     throttle_time = 80,
    --     source_timeout = 200,
    --     incomplete_delay = 400,
    --     max_abbr_width = 100,
    --     max_kind_width = 100,
    --     max_menu_width = 100,

    --     source = {
    --         path = false,
    --         buffer = true,
    --         calc = true,
    --         vsnip = true,
    --         nvim_lsp = true,
    --         nvim_lua = true,
    --         ultisnips = true,
    --         snippets_nvim = true,
    --         spell = false,
    --         tags = false
    --     }
    -- }
end
