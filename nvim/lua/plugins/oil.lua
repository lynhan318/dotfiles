return {
    "stevearc/oil.nvim",
    opts = function()
        local detail = false
        return {
            default_file_explorer = true,
            constrain_cursor = false,
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            prompt_save_on_select_new_entry = false,
            watch_for_changes = true,
            lsp_file_methods = {
                autosave_changes = true,
            },
            preview_win = {
                -- "fast_scratch" only loads the visible page, so scrolling stops
                -- after the first <C-d>. "scratch" loads the whole file.
                preview_method = "scratch",
            },
            float = {
                padding = 2,
                max_width = 0,
                max_height = 0,
                win_options = {
                    winblend = 0,
                },
                override = function(conf)
                    return conf
                end,
            },
            keymaps = {
                ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
                ["<C-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
                ["<C-d>"] = "actions.preview_scroll_down",
                ["<C-u>"] = "actions.preview_scroll_up",
                ["gd"] = {
                    desc = "Toggle file detail view",
                    callback = function()
                        detail = not detail
                        if detail then
                            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
                        else
                            require("oil").set_columns({ "icon" })
                        end
                    end,
                },
            },
        }
    end,
    keys = { {
        "-",
        "<cmd>Oil --float --preview<cr>",
        desc = "OilTree",
        mode = "n",
    } },
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
