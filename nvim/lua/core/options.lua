local opt = vim.opt
local g = vim.g

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = "a"                               -- Enable mouse support
opt.clipboard = "unnamedplus"                 -- Copy/paste to system clipboard
opt.swapfile = false                          -- Don't use swapfile
opt.completeopt = "menuone,noinsert,noselect" -- Autocomplete options

-- Use Ripgrep
vim.o.grepprg = "rg --vimgrep"
vim.o.grepformat = "%f:%l:%c:%m"

-----------------------------------------------------------
-- Enable fold for nvim-ufo
-----------------------------------------------------------
-- Folding
-- Enable fold for nvim-ufo
vim.o.foldenable = true
-- Set high foldlevel for nvim-ufo
vim.o.foldlevel = 99
-- Start with all code unfolded
vim.o.foldlevelstart = 99
vim.o.foldcolumn = "0"
vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵]]
-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true        -- Show line number
opt.showmatch = true     -- Highlight matching parenthesis
--opt.colorcolumn = '80' -- Line lenght marker at 80 columns
opt.splitright = true    -- Vertical split to the right
opt.splitbelow = true    -- Horizontal split to the bottom
opt.ignorecase = true    -- Ignore case letters when search
opt.smartcase = true     -- Ignore lowercase for the whole pattern
opt.linebreak = false    -- Wrap on word boundary
opt.termguicolors = true -- Enable 24-bit RGB colors
opt.laststatus = 3       -- Set global statusline
opt.signcolumn = "yes"
opt.relativenumber = true

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true   -- Use spaces instead of tabs
opt.shiftwidth = 4     -- Shift 4 spaces when tab
opt.tabstop = 4        -- 1 tab == 4 spaces
opt.smartindent = true -- Autoindent new lines

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true     -- Enable background buffers
opt.history = 100     -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240   -- Max column for syntax highlight
opt.updatetime = 250  -- ms to wait for trigger an event

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- Disable nvim intro
opt.shortmess:append "sI"
-- -- Disable builtin plugins
local disabled_built_ins = {
    "2html_plugin",
    "getscript",
    "getscriptPlugin",
    "gzip",
    "logipat",
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "matchit",
    "tar",
    "tarPlugin",
    "rrhelper",
    "spellfile_plugin",
    "vimball",
    "vimballPlugin",
    "zip",
    "zipPlugin",
    "tutor",
    "rplugin",
    "synmenu",
    "optwin",
    "compiler",
    "bugreport",
    "ftplugin",
}
vim.filetype.add {
    extension = {
        mdx = "mdx",
    },
}

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end
