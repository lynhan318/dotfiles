-- LazyVim's statusline, ported to stand on its own.
--
-- Left : root dir | diagnostics | filetype icon + path | code context
-- Right: dap | pending plugin updates | git diff | progress + location
--
-- LazyVim builds this from its own runtime (LazyVim.lualine.*, LazyVim.root,
-- LazyVim.config.icons), none of which exists here, so the pieces that matter
-- are reimplemented below.

-- Every glyph the statusline draws, in one place. Each carries its own padding,
-- so the components below concatenate instead of padding at the call site.
--
-- Written out here rather than inline because the whole set was silently lost
-- once already: these are private-use codepoints, and the four-byte ones
-- (\u{f126d}, \u{f033e}) survived a round-trip that flattened every three-byte
-- one to a bare space. If the bar ever goes back to showing counts with no
-- symbol in front of them, this table is what to check.
local icons = {
    -- The gutter's diagnostic signs, reused verbatim from
    -- lua/plugins/lspconfig/init.lua, so a count up here and a sign out in the
    -- margin are recognisably the same thing.
    diagnostics = { Error = " ", Warn = " ", Info = "󰋼 ", Hint = "󰌵 " },
    git = { added = " ", modified = " ", removed = " " },
    misc = {
        root = "󱉭  ",
        readonly = " 󰌾 ",
        debug = "  ",
    },
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
        readonly_icon = icons.misc.readonly,
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
            return icons.misc.root .. (get() or "")
        end,
        cond = function()
            return type(get()) == "string"
        end,
        color = fg("Special"),
    }
end

-- lualine ships no theme for this colourscheme, and `theme = "auto"` cannot
-- stand in for one: auto derives its sections from Normal and StatusLine, and
-- lua/plugins/base16.lua deliberately strips the background off both so the
-- terminal shows through. With no bg to read, auto falls back to #000000 --
-- the black slab that used to fill the middle of the bar while the buffer above
-- it stayed translucent.
--
-- So build the theme from the palette directly. base16-nvim keeps the active
-- colours on its own module table, and lua/matugen.lua rewrites them on every
-- wallpaper change, which is what lets the statusline follow the desktop.
local function palette_theme()
    local ok, base16 = pcall(require, "base16-colorscheme")
    if not ok or type(base16.colors) ~= "table" or not base16.colors.base00 then
        return "auto"
    end
    local c = base16.colors

    -- a and z carry the mode colour, b and y sit on the palette's raised
    -- background, and c and x stay transparent so the middle of the bar is the
    -- same terminal background as the buffer above it. lualine mirrors x onto
    -- c, y onto b and z onto a, so three entries cover all six sections.
    --
    -- Only c, x and y are filled below, so in practice the mode colours never
    -- reach the screen. They stay defined so that putting `"mode"` back in
    -- lualine_a is a one-word change rather than a re-theming job.
    local function mode(accent)
        return {
            a = { fg = c.base00, bg = accent, gui = "bold" },
            b = { fg = c.base05, bg = c.base01 },
            c = { fg = c.base04, bg = "NONE" },
        }
    end

    -- Normal mode takes base0B, the palette's green, because that is the slot
    -- matugen fills with the accent Noctalia uses for the bar and herdr.
    return {
        normal = mode(c.base0B),
        insert = mode(c.base0D),
        visual = mode(c.base0E),
        replace = mode(c.base08),
        command = mode(c.base0A),
        terminal = mode(c.base0C),
        inactive = {
            a = { fg = c.base03, bg = "NONE" },
            b = { fg = c.base03, bg = "NONE" },
            c = { fg = c.base03, bg = "NONE" },
        },
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
                theme = palette_theme(),
                globalstatus = vim.o.laststatus == 3,
                disabled_filetypes = { statusline = { "snacks_dashboard", "dashboard", "alpha" } },
            },
            sections = {
                -- Deliberately bare on the left. The mode is already obvious
                -- from the cursor, the branch is one `:G` away, and the
                -- Noctalia bar overhead carries the time and date -- none of
                -- the three earns permanent space down here.
                lualine_a = {},
                lualine_b = {},
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
                            return icons.misc.debug .. require("dap").status()
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
                lualine_z = {},
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
    config = function(_, opts)
        require("lualine").setup(opts)

        -- matugen rewrites the palette in place and never runs `:colorscheme`,
        -- so lualine's own ColorScheme hook never fires and the theme built
        -- above would keep the colours of whatever wallpaper was up at startup.
        -- base16.lua announces the change instead. Re-setting only `options`
        -- merges over the stored config, so the sections survive untouched.
        vim.api.nvim_create_autocmd("User", {
            pattern = "PaletteChanged",
            callback = function()
                require("lualine").setup({ options = { theme = palette_theme() } })
            end,
        })
    end,
}
