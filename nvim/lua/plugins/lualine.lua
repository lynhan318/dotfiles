-- LazyVim's statusline, ported to stand on its own.
--
-- Left : mode | branch | root dir | diagnostics | filetype icon + path | code context
-- Right: dap | pending plugin updates | git diff | progress + location | clock
--
-- LazyVim builds this from its own runtime (LazyVim.lualine.*, LazyVim.root,
-- LazyVim.config.icons), none of which exists here, so the pieces that matter
-- are reimplemented below.

local icons = {
    diagnostics = { Error = " ", Warn = " ", Hint = " ", Info = " " },
    git = { added = " ", modified = " ", removed = " " },
}

-- Foreground of a highlight group, resolved on each redraw so it keeps up with
-- colorscheme changes (base16/matugen swap these out at runtime).
local function fg(name)
    return function()
        local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
        if hl and hl.fg then
            return { fg = string.format("#%06x", hl.fg) }
        end
    end
end

-- Project root: the root_dir of an attached LSP client, else the nearest .git,
-- else cwd. LazyVim.root.get() is considerably more elaborate; this covers the
-- cases the statusline actually cares about.
local function get_root()
    local buf = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(buf)

    if name ~= "" and not name:match("^%w+://") then
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = buf })) do
            local dir = client.config.root_dir
            if dir and name:find(dir, 1, true) == 1 then
                return dir
            end
        end
        local git = vim.fs.find(".git", { path = vim.fs.dirname(name), upward = true })[1]
        if git then
            return vim.fs.dirname(git)
        end
    end

    return vim.uv.cwd() or ""
end

-- Wrap text in a lualine-managed highlight derived from an existing group, so a
-- single component can render a dimmed directory and a bold filename.
local function format(component, text, hl_group)
    text = text:gsub("%%", "%%%%")
    if not hl_group or hl_group == "" then
        return text
    end

    component.hl_cache = component.hl_cache or {}
    local cached = component.hl_cache[hl_group]
    if not cached then
        local utils = require("lualine.utils.utils")
        local gui = vim.tbl_filter(function(x)
            return x
        end, {
            utils.extract_highlight_colors(hl_group, "bold") and "bold",
            utils.extract_highlight_colors(hl_group, "italic") and "italic",
        })
        cached = component:create_hl({
            fg = utils.extract_highlight_colors(hl_group, "fg"),
            gui = #gui > 0 and table.concat(gui, ",") or nil,
        }, "PP_" .. hl_group)
        component.hl_cache[hl_group] = cached
    end

    return component:format_hl(cached) .. text .. component:get_default_hl()
end

-- "lua/plugins/theme.lua" - relative to cwd, falling back to the project root
-- when the file sits outside it. Trimmed to the last few segments.
local function pretty_path(opts)
    opts = vim.tbl_extend("force", {
        modified_hl = "MatchParen",
        filename_hl = "Bold",
        directory_hl = "",
        modified_sign = "",
        readonly_icon = " 󰌾 ",
        length = 3,
    }, opts or {})

    return function(self)
        local path = vim.fn.expand("%:p")
        if path == "" then
            return ""
        end
        path = vim.fs.normalize(path)

        local cwd = vim.fs.normalize(vim.uv.cwd() or "")
        local root = vim.fs.normalize(get_root())

        if cwd ~= "" and path:find(cwd, 1, true) == 1 then
            path = path:sub(#cwd + 2)
        elseif root ~= "" and path:find(root, 1, true) == 1 then
            path = path:sub(#root + 2)
        end

        local parts = vim.split(path, "[\\/]")
        if opts.length > 0 and #parts > opts.length then
            parts = { parts[1], "…", unpack(parts, #parts - opts.length + 2, #parts) }
        end

        if opts.modified_hl and vim.bo.modified then
            parts[#parts] = format(self, parts[#parts] .. opts.modified_sign, opts.modified_hl)
        else
            parts[#parts] = format(self, parts[#parts], opts.filename_hl)
        end

        local dir = ""
        if #parts > 1 then
            dir = format(self, table.concat({ unpack(parts, 1, #parts - 1) }, "/") .. "/", opts.directory_hl)
        end

        local readonly = vim.bo.readonly and format(self, opts.readonly_icon, opts.modified_hl) or ""

        return dir .. parts[#parts] .. readonly
    end
end

-- Name of the project root, shown only when it differs from cwd.
local function root_dir()
    local function get()
        local cwd = vim.fs.normalize(vim.uv.cwd() or "")
        local root = vim.fs.normalize(get_root())
        if root == "" or root == cwd then
            return nil
        end
        return vim.fs.basename(root)
    end

    return {
        function()
            return "󱉭  " .. (get() or "")
        end,
        cond = function()
            return type(get()) == "string"
        end,
        color = fg("Special"),
    }
end

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        -- Only pulled in for the "ƒ config" breadcrumb below.
        { "folke/trouble.nvim", opts = {} },
    },
    init = function()
        -- Keep the default statusline out of sight until lualine takes over.
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            vim.o.statusline = " "
        else
            vim.o.laststatus = 0
        end
    end,
    opts = function()
        vim.o.laststatus = vim.g.lualine_laststatus

        local opts = {
            options = {
                theme = "auto",
                globalstatus = vim.o.laststatus == 3,
                disabled_filetypes = { statusline = { "snacks_dashboard", "dashboard", "alpha" } },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = {
                    root_dir(),
                    {
                        "diagnostics",
                        symbols = {
                            error = icons.diagnostics.Error,
                            warn = icons.diagnostics.Warn,
                            info = icons.diagnostics.Info,
                            hint = icons.diagnostics.Hint,
                        },
                    },
                    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    { pretty_path() },
                },
                lualine_x = {
                    {
                        function()
                            return "  " .. require("dap").status()
                        end,
                        cond = function()
                            return package.loaded["dap"] and require("dap").status() ~= ""
                        end,
                        color = fg("Debug"),
                    },
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = fg("Special"),
                    },
                    {
                        "diff",
                        symbols = {
                            added = icons.git.added,
                            modified = icons.git.modified,
                            removed = icons.git.removed,
                        },
                    },
                },
                lualine_y = {
                    { "progress", separator = " ", padding = { left = 1, right = 0 } },
                    { "location", padding = { left = 0, right = 1 } },
                },
                lualine_z = {
                    function()
                        return " " .. os.date("%R")
                    end,
                },
            },
            extensions = { "lazy", "quickfix", "fugitive", "nvim-dap-ui", "oil", "trouble" },
        }

        -- The "ƒ config" breadcrumb: where the cursor sits in the document
        -- symbol tree, rendered by trouble.nvim.
        local ok, trouble = pcall(require, "trouble")
        if ok then
            local symbols = trouble.statusline({
                mode = "symbols",
                groups = {},
                title = false,
                filter = { range = true },
                format = "{kind_icon}{symbol.name:Normal}",
                hl_group = "lualine_c_normal",
            })
            table.insert(opts.sections.lualine_c, {
                symbols.get,
                cond = function()
                    return vim.b.trouble_lualine ~= false and symbols.has()
                end,
            })
        end

        return opts
    end,
}
