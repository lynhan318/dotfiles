return function()
    vim.cmd('nnoremap <Leader>p <cmd>Files<CR>')
    vim.cmd('nnoremap <Leader>l <cmd>Rg<CR>')
    vim.cmd('nnoremap <nowait><Leader>b <cmd>Buffers<CR>')
    vim.cmd('nnoremap <Leader>s <cmd>GFiles?<CR>')
end
