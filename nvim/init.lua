local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- Auto-install lazy.nvim if not present
if not vim.uv.fs_stat(lazypath) then
  print "Installing lazy.nvim...."
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require "core/options"
require "core/autocmds"
require "core/keymaps"
require("lazy").setup "plugins"
