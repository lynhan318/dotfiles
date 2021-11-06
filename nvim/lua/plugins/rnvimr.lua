return function()
    -- mappings
    vim.api.nvim_set_keymap('n', '<leader>r', ':RnvimrToggle<CR>',
                            {noremap = true})

    vim.g.rnvimr_ex_enable = 1 -- Make Ranger replace netrw and be the file explorer
end
