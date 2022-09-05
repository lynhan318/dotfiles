return function()
    local cmd = vim.cmd
    cmd 'syntax on'

    -- sonokai theme
    -- cmd 'colorscheme sonokai'
    -- vim.g.sonokai_style = 'maia'
    -- vim.g.sonokai_enable_italic = 0
    -- vim.g.sonokai_disable_italic_comment = 1

    -- everforest theme
    vim.g.everforest_background = 'soft'
    vim.g.everforest_enable_italic = 1
    vim.g.everforest_disable_italic_comment = 0
    cmd 'set background=dark'
    cmd 'set termguicolors'
    cmd 'colorscheme everforest'

end
