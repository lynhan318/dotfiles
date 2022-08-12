return function()

    vim.cmd('nnoremap <Leader>p <cmd>FzfLua files<CR>')
    vim.cmd('nnoremap <Leader>l <cmd>FzfLua live_grep_native<CR>')
    vim.cmd('nnoremap <nowait><Leader>b <cmd>FzfLua buffers<CR>')
    -- vim.cmd('nnoremap <Leader>g <cmd>FzfLua git_files<CR>')
    vim.cmd('nnoremap <Leader>s <cmd>FzfLua git_status<CR>')
    require'fzf-lua'.setup {
        -- fzf_bin = 'sk', -- use skim instead of fzf?
        -- https://github.com/lotabout/skim
        global_resume = true, -- enable global `resume`?
        -- can also be sent individually:
        -- `<any_function>.({ gl ... })`
        global_resume_query = true, -- include typed query in `resume`?
        winopts = {
            -- split         = "belowright new",-- open in a split instead?
            -- "belowright new"  : split below
            -- "aboveleft new"   : split above
            -- "belowright vnew" : split right
            -- "aboveleft vnew   : split left
            -- Only valid when using a float window
            -- (i.e. when 'split' is not defined, default)
            height = 0.85, -- window height
            width = 0.80, -- window width
            row = 0.35, -- window row position (0=top, 1=bottom)
            col = 0.50, -- window col position (0=left, 1=right)
            -- border argument passthrough to nvim_open_win(), also used
            -- to manually draw the border characters around the preview
            -- window, can be set to 'false' to remove all borders or to
            -- 'none', 'single', 'double' or 'rounded' (default)
            border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'},
            fullscreen = false, -- start fullscreen?
            hl = {
                normal = 'Normal', -- window normal color (fg+bg)
                border = 'Normal', -- border color (try 'FloatBorder')
                -- Only valid with the builtin previewer:
                cursor = 'Cursor', -- cursor highlight (grep/LSP matches)
                cursorline = 'CursorLine', -- cursor line
                search = 'Search' -- search matches (ctags)
                -- title       = 'Normal',        -- preview border title (file/buffer)
                -- scrollbar_f = 'PmenuThumb',    -- scrollbar "full" section highlight
                -- scrollbar_e = 'PmenuSbar',     -- scrollbar "empty" section highlight
            },
            preview = {
                -- default     = 'bat',           -- override the default previewer?
                -- default uses the 'builtin' previewer
                border = 'border', -- border|noborder, applies only to
                -- native fzf previewers (bat/cat/git/etc)
                wrap = 'nowrap', -- wrap|nowrap
                hidden = 'nohidden', -- hidden|nohidden
                vertical = 'down:45%', -- up|down:size
                horizontal = 'right:60%', -- right|left:size
                layout = 'vertical', -- horizontal|vertical|flex
                flip_columns = 120, -- #cols to switch to horizontal on flex
                -- Only valid with the builtin previewer:
                title = true, -- preview border title (file/buf)?
                scrollbar = 'float', -- `false` or string:'float|border'
                -- float:  in-window floating border
                -- border: in-border chars (see below)
                scrolloff = '-2', -- float scrollbar offset from right
                -- applies only when scrollbar = 'float'
                scrollchars = {'█', ''}, -- scrollbar chars ({ <full>, <empty> }
                -- applies only when scrollbar = 'border'
                delay = 100, -- delay(ms) displaying the preview
                -- prevents lag on fast scrolling
                winopts = { -- builtin previewer window options
                    number = true,
                    relativenumber = false,
                    cursorline = true,
                    cursorlineopt = 'both',
                    cursorcolumn = false,
                    signcolumn = 'no',
                    list = false,
                    foldenable = false,
                    foldmethod = 'manual'
                }
            },
            on_create = function()
                -- called once upon creation of the fzf main window
                -- can be used to add custom fzf-lua mappings, e.g:
                --   vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", "<Down>",
                --     { silent = true, noremap = true })
            end
        },
        previewers = {
            cat = {cmd = "cat", args = "--number"},
            bat = {
                cmd = "bat",
                args = "--style=numbers,changes --color always",
                theme = 'Coldark-Dark', -- bat preview theme (bat --list-themes)
                config = nil -- nil uses $BAT_CONFIG_PATH
            },
            head = {cmd = "head", args = nil},
            git_diff = {
                cmd_deleted = "git diff --color HEAD --",
                cmd_modified = "git diff --color HEAD",
                cmd_untracked = "git diff --color --no-index /dev/null"
                -- pager        = "delta",      -- if you have `delta` installed
            },
            man = {
                -- NOTE: remove the `-c` flag when using man-db
                cmd = "man -c %s | col -bx"
            },
            builtin = {
                syntax = true, -- preview syntax highlight?
                syntax_limit_l = 0, -- syntax limit (lines), 0=nolimit
                syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
                limit_b = 1024 * 1024 * 10, -- preview limit (bytes), 0=nolimit
                -- preview extensions using a custom shell command:
                -- for example, use `viu` for image previews
                -- will do nothing if `viu` isn't executable
                extensions = {
                    -- neovim terminal only supports `viu` block output
                    ["png"] = {"viu", "-b"},
                    ["jpg"] = {"ueberzug"}
                },
                -- if using `ueberzug` in the above extensions map
                -- set the default image scaler, possible scalers:
                --   false (none), "crop", "distort", "fit_contain",
                --   "contain", "forced_cover", "cover"
                -- https://github.com/seebye/ueberzug
                ueberzug_scaler = "cover"
            }
        },
        -- provider setup
        quickfix = {file_icons = true, git_icons = true}
    }
end
