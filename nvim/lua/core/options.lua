local opt = vim.opt
local g = vim.g

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true                          -- persistent undo
opt.undolevels = 10000
opt.confirm = true                           -- prompt to save instead of failing
opt.completeopt = "menuone,noinsert,noselect"

-- Use Ripgrep
vim.o.grepprg = "rg --vimgrep"
vim.o.grepformat = "%f:%l:%c:%m"

-----------------------------------------------------------
-- Folding (nvim-ufo)
-----------------------------------------------------------
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldcolumn = "0"
opt.fillchars = [[eob: ,fold: ,foldopen:▼,foldsep: ,foldclose:⏵,diff:╱]]

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true
opt.relativenumber = true
opt.showmatch = true
opt.cursorline = true                         -- highlight current line
opt.colorcolumn = "100"                       -- ruler
opt.signcolumn = "yes"
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"                      -- don't scroll on split
opt.winminwidth = 5
opt.ignorecase = true
opt.smartcase = true
opt.linebreak = false
opt.wrap = false                              -- IDE-style: no soft wrap
opt.termguicolors = true
opt.laststatus = 3                            -- global statusline
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.pumheight = 12
opt.pumblend = 10
opt.inccommand = "split"                      -- live preview of :s
opt.smoothscroll = true
opt.jumpoptions = "view"
opt.virtualedit = "block"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", extends = "›", precedes = "‹" }

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
opt.formatoptions = "jcroqlnt"

-----------------------------------------------------------
-- Performance
-----------------------------------------------------------
opt.hidden = true
opt.history = 100
opt.synmaxcol = 240
opt.updatetime = 200
opt.timeoutlen = 400
opt.redrawtime = 1500
-- NOTE: lazyredraw removed — conflicts with modern UI plugins

-----------------------------------------------------------
-- Session
-----------------------------------------------------------
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
opt.shortmess:append("sIWcC")

local disabled_built_ins = {
  "2html_plugin", "getscript", "getscriptPlugin", "gzip", "logipat",
  "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
  "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin",
  "vimball", "vimballPlugin", "zip", "zipPlugin", "tutor",
  "rplugin", "synmenu", "optwin", "compiler", "bugreport", "ftplugin",
}
for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

vim.filetype.add({ extension = { mdx = "mdx" } })
