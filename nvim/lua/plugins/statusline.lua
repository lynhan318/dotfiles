return function()
    local colors = {
        bg = "NONE",
        -- bg = "#2E3440",
        fg = "#81A1C1",
        line_bg = "NONE",
        lbg = "#3B4252",
        fg_green = "#8FBCBB",
        yellow = "#EBCB8B",
        cyan = "#A3BE8C",
        darkblue = "#81A1C1",
        green = "#8FBCBB",
        orange = "#D08770",
        purple = "#B48EAD",
        magenta = "#BF616A",
        gray = "#616E88",
        blue = "#5E81AC",
        red = "#BF616A"
    }

    local function reverse(tbl)
        for i = 1, math.floor(#tbl / 2) do
            local j = #tbl - i + 1
            tbl[i], tbl[j] = tbl[j], tbl[i]
        end
    end

    function get_tail(filename) return vim.fn.fnamemodify(filename, ":t") end

    function split_filename(filename)
        local nodes = {}
        for parent in string.gmatch(filename, "[^/]+/") do
            table.insert(nodes, parent)
        end
        table.insert(nodes, get_tail(filename))
        return nodes
    end

    function reverse_filename(filename)
        local parents = split_filename(filename)
        reverse(parents)
        return parents
    end

    local function same_until(first, second)
        for i = 1, #first do if first[i] ~= second[i] then return i end end
        return 1
    end

    function get_unique_filename(filename, other_filenames)
        local rv = ''

        local others_reversed = vim.tbl_map(reverse_filename, other_filenames)
        local filename_reversed = reverse_filename(filename)
        local same_until_map = vim.tbl_map(function(second)
            return same_until(filename_reversed, second)
        end, others_reversed)

        local max = 0
        for _, v in ipairs(same_until_map) do if v > max then max = v end end
        for i = max, 1, -1 do rv = rv .. filename_reversed[i] end

        return rv
    end

    function get_current_ufn()
        local buffers = vim.fn.getbufinfo()
        local listed = vim.tbl_filter(function(buffer)
            return buffer.listed == 1
        end, buffers)
        local names = vim.tbl_map(function(buffer) return buffer.name end,
                                  listed)
        local current_name = vim.fn.expand("%")
        return get_unique_filename(current_name, names)
    end

    local vi_mode_colors = {
        NORMAL = colors.green,
        INSERT = colors.blue,
        VISUAL = colors.violet,
        OP = colors.green,
        BLOCK = colors.blue,
        REPLACE = colors.red,
        ['V-REPLACE'] = colors.red,
        ENTER = colors.cyan,
        MORE = colors.cyan,
        SELECT = colors.orange,
        COMMAND = colors.magenta,
        SHELL = colors.green,
        TERM = colors.blue,
        NONE = colors.yellow
    }
    local vi_mode_text = {
        n = "NORMAL",
        i = "INSERT",
        v = "VISUAL",
        [''] = "V-BLOCK",
        V = "V-LINE",
        c = "COMMAND",
        no = "UNKNOWN",
        s = "UNKNOWN",
        S = "UNKNOWN",
        ic = "UNKNOWN",
        R = "REPLACE",
        Rv = "UNKNOWN",
        cv = "UNKWON",
        ce = "UNKNOWN",
        r = "REPLACE",
        rm = "UNKNOWN",
        t = "INSERT"
    }

    local function file_osinfo()
        local os = vim.bo.fileformat:upper()
        local icon
        if os == 'UNIX' then
            icon = ' '
        elseif os == 'MAC' then
            icon = ' '
        else
            icon = ' '
        end
        return icon .. os
    end

    local function get_filename(component, modifiers)
        -- local filename = vim.fn.expand('%:t')
        local modifiers_str = table.concat(modifiers, ":")
        local filename = vim.fn.expand("%" .. modifiers_str)
        local extension = vim.fn.expand('%:e')
        local modified_str

        local icon = component.icon or
                         require'nvim-web-devicons'.get_icon(filename,
                                                             extension,
                                                             {default = true})

        if filename == '' then filename = 'unnamed' end

        if vim.bo.modified then
            local modified_icon = component.file_modified_icon or '●'
            modified_str = modified_icon .. ' '
        else
            modified_str = ''
        end

        return icon .. ' ' .. filename .. ' ' .. modified_str
    end

    local lsp = require 'feline.providers.lsp'
    local vi_mode_utils = require 'feline.providers.vi_mode'
    local cursor = require 'feline.providers.cursor'

    -- LuaFormatter off

    local comps = {
        vi_mode = {
            left = {
                provider = function()
                    local current_text = ' '..vi_mode_text[vim.fn.mode()]..' '
                    return current_text
                end,
                hl = function()
                    local val = {
                        name = vi_mode_utils.get_mode_highlight_name(),
                        fg = colors.bg,
                        bg = vi_mode_utils.get_mode_color(),
                        style = 'bold'
                    }
                    return val
                end
                -- right_sep = ' '
            },
            right = {
                provider = '▊',
                hl = function()
                    local val = {
                        name = vi_mode_utils.get_mode_highlight_name(),
                        fg = vi_mode_utils.get_mode_color()
                    }
                    return val
                end,
                left_sep = ' '
            }
        },
        file = {
            info = {
                -- provider = 'file_info',
                provider = get_current_ufn,
                hl = {
                    fg = colors.blue,
                    style = 'bold'
                },
                left_sep = ' '
            },
            encoding = {
                provider = 'file_encoding',
                left_sep = ' ',
                hl = {
                    fg = colors.violet,
                    style = 'bold'
                }
            },
            type = {
                provider = 'file_type'
            },
            os = {
                provider = file_osinfo,
                left_sep = ' ',
                hl = {
                    fg = colors.violet,
                    style = 'bold'
                }
            }
        },
        line_percentage = {
            provider = 'line_percentage',
            left_sep = ' ',
            hl = {
                style = 'bold'
            }
        },
        position = {
            provider = function()
                pos = cursor.position()
                return ' '..pos..' '
            end,
            left_sep = ' ',
            hl = function()
                local val = {
                    name = vi_mode_utils.get_mode_highlight_name(),
                    fg = colors.bg,
                    bg = vi_mode_utils.get_mode_color(),
                    style = 'bold'
                }
                return val
            end
        },
        scroll_bar = {
            provider = 'scroll_bar',
            left_sep = ' ',
            hl = {
                fg = colors.blue,
                style = 'bold'
            }
        },
        diagnos = {
            err = {
                provider = 'diagnostic_errors',
                enabled = function()
                    return lsp.diagnostics_exist('Error')
                end,
                hl = {
                    fg = colors.red
                }
            },
            warn = {
                provider = 'diagnostic_warnings',
                enabled = function()
                    return lsp.diagnostics_exist('Warning')
                end,
                hl = {
                    fg = colors.yellow
                }
            },
            hint = {
                provider = 'diagnostic_hints',
                enabled = function()
                    return lsp.diagnostics_exist('Hint')
                end,
                hl = {
                    fg = colors.cyan
                }
            },
            info = {
                provider = 'diagnostic_info',
                enabled = function()
                    return lsp.diagnostics_exist('Information')
                end,
                hl = {
                    fg = colors.blue
                }
            },
        },
        lsp = {
            name = {
                provider = 'lsp_client_names',
                left_sep = ' ',
                icon = ' ',
                hl = {
                    fg = colors.yellow
                }
            }
        },
        git = {
            branch = {
                provider = 'git_branch',
                icon = ' ',
                left_sep = ' ',
                hl = {
                    fg = colors.violet,
                    style = 'bold'
                },
            },
            add = {
                provider = 'git_diff_added',
                hl = {
                    fg = colors.green
                }
            },
            change = {
                provider = 'git_diff_changed',
                hl = {
                    fg = colors.orange
                }
            },
            remove = {
                provider = 'git_diff_removed',
                hl = {
                    fg = colors.red
                }
            }
        }
    }

    local properties = {
        force_inactive = {
            filetypes = {
                'NvimTree',
                'defx',
                'dbui',
                'packer',
                'startify',
                'fugitive',
                'fugitiveblame'
            },
            buftypes = {'terminal'},
            bufnames = {}
        }
    }

    local components = {
        left = {
            active = {
                comps.vi_mode.left,
                comps.file.info,
                comps.lsp.name,
                comps.diagnos.err,
                comps.diagnos.warn,
                comps.diagnos.hint,
                comps.diagnos.info
            },
            inactive = {
                comps.file.info
            }
        },
        mid = {
            active = {},
            inactive = {}
        },
        right = {
            active = {
                comps.git.add,
                comps.git.change,
                comps.git.remove,
                comps.file.os,
                comps.git.branch,
                comps.scroll_bar,
                comps.line_percentage,
                -- comps.vi_mode.right
                comps.position
            },
            inactive = {
                comps.file.os
            }
        }
    }

    -- LuaFormatter on

    require'feline'.setup {
        default_bg = colors.bg,
        default_fg = colors.fg,
        components = components,
        properties = properties,
        vi_mode_colors = vi_mode_colors
    }
end
