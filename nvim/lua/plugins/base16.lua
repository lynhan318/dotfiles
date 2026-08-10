-- Created once by Noctalia's neovim template (its apply.sh only writes this
-- file when it is missing, so edits here stick). lua/matugen.lua *is*
-- regenerated on every palette change — don't edit that one.
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
        local ok, matugen = pcall(require, 'matugen')
        if ok then matugen.setup() end
    end,
}
