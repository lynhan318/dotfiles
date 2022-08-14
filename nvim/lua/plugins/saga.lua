return function()
    local saga = require("lspsaga")
    saga.init_lsp_saga({
        -- Options with default value
        -- "single" | "double" | "rounded" | "bold" | "plus"
        border_style = "single",
        -- the range of 0 for fully opaque window (disabled) to 100 for fully
        -- transparent background. Values between 0-30 are typically most useful.
        saga_winblend = 0,
        -- when cursor in saga window you config these to move
        move_in_saga = {prev = '<C-p>', next = '<C-n>'},
        -- Error, Warn, Info, Hint
        -- use emoji like
        -- { "🙀", "😿", "😾", "😺" }
        -- or
        -- { "😡", "😥", "😤", "😐" }
        -- and diagnostic_header can be a function type
        -- must return a string and when diagnostic_header
        -- is function type it will have a param `entry`
        -- entry is a table type has these filed
        -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
        diagnostic_header = {" ", " ", " ", "ﴞ "},
        -- show diagnostic source
        show_diagnostic_source = true,
        -- add bracket or something with diagnostic source, just have 2 elements
        diagnostic_source_bracket = {},
        -- preview lines of lsp_finder and definition preview
        max_preview_lines = 10,
        -- use emoji lightbulb in default
        code_action_icon = "💡",
        -- if true can press number to execute the codeaction in codeaction window
        code_action_num_shortcut = true,
        -- same as nvim-lightbulb but async
        code_action_lightbulb = {
            enable = true,
            sign = true,
            enable_in_insert = true,
            sign_priority = 20,
            virtual_text = true
        },
        -- finder icons
        finder_icons = {def = '  ', ref = '諭 ', link = '  '},
        -- finder do lsp request timeout
        -- if your project big enough or your server very slow
        -- you may need to increase this value
        finder_request_timeout = 1500,
        finder_action_keys = {
            open = "o",
            vsplit = "s",
            split = "i",
            tabe = "t",
            quit = "q",
            scroll_down = "<C-f>",
            scroll_up = "<C-b>" -- quit can be a table
        },
        code_action_keys = {quit = "q", exec = "<CR>"},
        rename_action_quit = "<C-c>",
        rename_in_select = true,
        definition_preview_icon = "  ",
        -- show symbols in winbar must nightly
        symbol_in_winbar = {
            in_custom = true,
            click_support = function(node, clicks, button, modifiers)
                -- To see all avaiable details: vim.pretty_print(node)
                local st = node.range.start
                local en = node.range['end']
                if button == "l" then
                    if clicks == 2 then
                        -- double left click to do nothing
                    else -- jump to node's starting line+char
                        vim.fn.cursor(st.line + 1, st.character + 1)
                    end
                elseif button == "r" then
                    if modifiers == "s" then
                        print "lspsaga" -- shift right click to print "lspsaga"
                    end -- jump to node's ending line+char
                    vim.fn.cursor(en.line + 1, en.character + 1)
                elseif button == "m" then
                    -- middle click to visual select node
                    vim.fn.cursor(st.line + 1, st.character + 1)
                    vim.cmd "normal v"
                    vim.fn.cursor(en.line + 1, en.character + 1)
                end
            end
        },
        -- show outline
        show_outline = {
            win_position = 'right',
            -- set special filetype win that outline window split.like NvimTree neotree
            -- defx, db_ui
            win_with = '',
            win_width = 30,
            auto_enter = true,
            auto_preview = true,
            virt_text = '┃',
            jump_key = 'o',
            -- auto refresh when change buffer
            auto_refresh = true
        },
        -- if you don't use nvim-lspconfig you must pass your server name and
        -- the related filetypes into this table
        -- like server_filetype_map = { metals = { "sbt", "scala" } }
        server_filetype_map = {}
    })

    local function get_file_name(include_path)
        local file_name = require('lspsaga.symbolwinbar').get_file_name()
        if vim.fn.bufname '%' == '' then return '' end
        if include_path == false then return file_name end
        -- Else if include path: ./lsp/saga.lua -> lsp > saga.lua
        local sep = vim.loop.os_uname().sysname == 'Windows' and '\\' or '/'
        local path_list = vim.split(string.gsub(vim.fn.expand '%:~:.:h', '%%',
                                                ''), sep)
        local file_path = ''
        for _, cur in ipairs(path_list) do
            file_path = (cur == '.' or cur == '~') and '' or file_path .. cur ..
                            ' ' .. '%#LspSagaWinbarSep#%*' .. ' %*'
        end
        return file_path .. file_name
    end

    local function config_winbar()
        local exclude = {
            ['teminal'] = true,
            ['toggleterm'] = true,
            ['prompt'] = true,
            ['Neotree'] = true,
            ['neo-tree'] = true,
            ['help'] = true
        } -- Ignore float windows and exclude filetype
        if vim.api.nvim_win_get_config(0).zindex or exclude[vim.bo.filetype] then
            vim.wo.winbar = ''
        else
            local ok, lspsaga = pcall(require, 'lspsaga.symbolwinbar')
            local sym
            if ok then sym = lspsaga.get_symbol_node() end
            local win_val = ''
            win_val = get_file_name(true) -- set to true to include path
            if sym ~= nil then win_val = win_val .. sym end
            vim.wo.winbar = win_val
        end
    end

    local events = {'BufEnter', 'BufWinEnter', 'CursorMoved'}

    vim.api.nvim_create_autocmd(events, {
        pattern = '*',
        callback = function() config_winbar() end
    })

    vim.api.nvim_create_autocmd('User', {
        pattern = 'LspsagaUpdateSymbol',
        callback = function() config_winbar() end
    })
    vim.keymap
        .set('n', '<leader>o', '<cmd>LSoutlineToggle<CR>', {silent = true})

end
