return function()
    local actions = require('telescope.actions')
    local action_state = require "telescope.actions.state"
    local utils = require "telescope.utils"

    vim.cmd('nnoremap <Leader>p <cmd>Telescope find_files<CR>')
    vim.cmd('nnoremap <Leader>l <cmd>Telescope live_grep<CR>')

    require('telescope').setup {
        pickers = {find_files = {theme = "ivy"}, live_grep = {theme = "ivy"}},
        defaults = {
            -- Default configuration for telescope goes here:
            -- config_key = value,
            layout_config = {},
            mappings = {
                i = {
                    ["<esc>"] = actions.close,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<tab>"] = actions.toggle_selection +
                        actions.move_selection_next,
                    ["<s-tab>"] = actions.toggle_selection +
                        actions.move_selection_previous
                },
                n = {["<esc>"] = actions.close}
            },
            vimgrep_arguments = {
                "rg", "--color=never", "--no-heading", "--with-filename",
                "--line-number", "--column", "--smart-case", "--hidden"
            }
        },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case" -- this is default
            },
            file_browser = {hidden = true}
        }
    }
    require("telescope").load_extension "fzf"
end
