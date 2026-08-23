-- Created once by Noctalia's neovim template (its apply.sh only writes this
-- file when it is missing, so edits here stick). lua/matugen.lua *is*
-- regenerated on every palette change — don't edit that one.

-- Groups whose background base16-nvim paints with base00/base01 and which we
-- want to let the terminal show through instead. base16-nvim has no
-- `transparent` option (its config table only toggles per-plugin highlights),
-- so this is a post-pass over what setup() just wrote.
--
-- Deliberately NOT in this list, because each one is a contrast element that
-- stops being readable without its own background:
--   CursorLine / CursorLineNr / ColorColumn — the "you are here" band
--   Visual, Search, IncSearch, Diff*        — selection and match feedback
--   Pmenu / PmenuSel                        — blink.cmp's menu (BlinkCmpMenu
--                                             links here) floats over code
local TRANSPARENT = {
    'Normal',
    'NormalNC',
    'NormalFloat',
    'FloatBorder',
    'FloatTitle',
    'SignColumn',
    'LineNr',
    'FoldColumn',
    'EndOfBuffer',
    'VertSplit',
    'WinSeparator',
    'StatusLine',
    'StatusLineNC',
    'TabLine',
    'TabLineFill',
    'TabLineSel',
    'MsgArea',
}

local function make_transparent()
    for _, group in ipairs(TRANSPARENT) do
        -- Read-modify-write rather than a fixed `{ fg = ..., bg = 'NONE' }`,
        -- so the foreground keeps whatever the current palette gave it —
        -- matugen rewrites those colours whenever the wallpaper changes.
        --
        -- No `link = false` here on purpose: a linked group comes back as
        -- `{ link = '...' }`, which we write straight back and leave the link
        -- intact, instead of flattening its target's attributes onto it.
        local hl = vim.api.nvim_get_hl(0, { name = group })
        if not vim.tbl_isempty(hl) then
            hl.bg, hl.ctermbg = nil, nil
            vim.api.nvim_set_hl(0, group, hl)
        end
    end
end

return {
    'RRethy/base16-nvim',
    -- The palette must be applied before any plugin that derives its own
    -- highlights from the colorscheme. bufferline caches what it derives at
    -- setup time and cannot recompute later — not even on a real ColorScheme
    -- event — so if it wins the startup race against this plugin, its tab strip
    -- keeps the default colorscheme's near-black shading for the whole session.
    -- lazy.nvim loads `lazy = false` plugins in priority order, highest first.
    lazy = false,
    priority = 1000,
    config = function()
        -- One repaint step, so everything downstream of a palette change has a
        -- single thing to hang off. base16-nvim rewrites highlights in place
        -- without ever running `:colorscheme`, so ColorScheme never fires and
        -- this User event is the only announcement a palette change makes.
        -- lua/plugins/lualine.lua listens for it to rebuild its theme.
        local function repaint()
            make_transparent()
            vim.api.nvim_exec_autocmds('User', { pattern = 'PaletteChanged', modeline = false })
        end

        local ok, matugen = pcall(require, 'matugen')
        if ok then matugen.setup() end
        repaint()

        -- matugen.lua listens for SIGUSR1 and re-runs its own setup() on a
        -- palette change, which repaints every background we just cleared.
        -- Re-apply after it.
        --
        -- A timer rather than a second `schedule_wrap` handler: matugen.lua
        -- registers a *fresh* uv signal handle on every reload (it clears
        -- package.loaded and re-requires, and the handle is created at module
        -- scope), so after the first palette change there are several of its
        -- callbacks queued ahead of ours in an order we cannot pin down.
        -- Deferring puts this on the far side of all of them.
        local signal = vim.uv.new_signal()
        signal:start('sigusr1', function()
            vim.defer_fn(repaint, 100)
        end)
    end,
}
