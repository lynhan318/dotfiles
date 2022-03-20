return function()
    vim.cmd('nnoremap <Leader>p <cmd>Fzflua files<CR>')
    vim.cmd('nnoremap <Leader>l <cmd>Fzflua grep<CR>')
    vim.cmd('nnoremap <Leader>g <cmd>Fzflua git_files<CR>')
end
