return function()
    vim.g.bufferline = {
        animation = true,
        tabpages = true,
        clickable = true,
        icon_close_tab = "",
        icon_separator_active = "",
        icon_separator_inactive = ""
    }
    vim.cmd("hi BufferTabpageFill guibg=NONE")
    vim.cmd("hi TabLine guibg=NONE")
end
