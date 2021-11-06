return function()
    require'compe'.setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = 'enable',
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,

        source = {
            path = false,
            buffer = true,
            calc = true,
            vsnip = true,
            nvim_lsp = true,
            nvim_lua = true,
            ultisnips = true,
            snippets_nvim = true,
            spell = false,
            tags = false
        }
    }
end
