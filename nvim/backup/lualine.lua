local M = {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy"
}

function M.init()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
        -- Set an empty statusline till lualine loads
        vim.o.statusline = " "
    else
        -- Hide the statusline on the starter page
        vim.o.laststatus = 0
    end
end

function M.config()
    local lualine = require("lualine")

    local function window()
        return vim.api.nvim_win_get_number(0)
    end

    lualine.setup({
        options = {
            theme = "auto",
            disabled_filetypes = {
                "help",
                "startuptime",
                "qf",
                "lspinfo",
                "checkhealth",
                "man",
                statusline = {"fugitive"}
            },
            globalstatus = true
        },
        extensions = {"fugitive", "lazy"},
        sections = {
            lualine_a = {"mode"},
            lualine_b = {"branch"},
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {"branch"},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
        },
        winbar = {
            lualine_a = {{
                "filename",
                path = 1
            }},
            lualine_b = {"diff", "diagnostics"},
            lualine_x = {"filetype"},
            lualine_y = {window, "progress"},
            lualine_z = {"location"}
        },
        inactive_winbar = {
            lualine_c = {"filename"},
            lualine_x = {window, "location"},
            lualine_z = {}
        }
    })
end

return M