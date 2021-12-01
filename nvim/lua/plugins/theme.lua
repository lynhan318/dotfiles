return function()
    local cmd = vim.cmd
    cmd 'syntax on'
    -- vim.g.sonokai_style = 'andromeda'
    -- vim.g.sonokai_enable_italic = 1
    -- vim.g.sonokai_disable_italic_comment = 1
    -- cmd 'colorscheme sonokai'

    vim.g.everforest_background = 'soft'
    cmd 'set background=dark'
    cmd 'colorscheme everforest'
    cmd 'set termguicolors'

end
