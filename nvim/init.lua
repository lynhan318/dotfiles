-- Reference: 
-- https://github.com/neanias/config
-- https://github.com/brainfucksec/neovim-lua#readme
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, 'lazy')
if not status_ok then
    return
end

require('core/options')
require('core/keymaps')
require('core/autocmds')

-- Start setup
lazy.setup("plugins", {
    defaults = {
        lazy = true,
        version = "*"
    }
})
