return function()
    require('lualine').setup {
        options = {
            theme = 'everforest',
            -- section_separators = {left = '', right = ''},
            -- component_separators = {left = '', right = ''},
            disabled_filetypes = {"neo-tree", 'winbar', 'statusline'},
            extensions = {'quickfix'},
            refresh = {statusline = 1000, tabline = 1000, winbar = 1000},
            section_separators = {left = '', right = ''},
            component_separators = ''

        }

    }
end
