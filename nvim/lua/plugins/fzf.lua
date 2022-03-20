return function()
    vim.cmd('nnoremap <Leader>p <cmd>FzfLua files<CR>')
    vim.cmd('nnoremap <Leader>l <cmd>FzfLua live_grep<CR>')
    -- vim.cmd('nnoremap <Leader>g <cmd>FzfLua git_files<CR>')
    vim.cmd('nnoremap <Leader>s <cmd>FzfLua git_status<CR>')
end
