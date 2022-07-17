return function()
    local cmd = vim.cmd
    cmd 'syntax on'

    -- sonokai theme
    -- cmd 'colorscheme sonokai'
    -- vim.g.sonokai_style = 'atlantis'
    -- vim.g.sonokai_enable_italic = 1
    -- vim.g.sonokai_disable_italic_comment = 1

    -- everforest thee
    vim.g.everforest_background = 'soft'
    cmd 'colorscheme everforest'

    cmd 'set background=dark'
    cmd 'set termguicolors'

end
