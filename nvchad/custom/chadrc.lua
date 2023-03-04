-- First read our docs (completely) then check the example_config repo

local M = {}

M.ui = {
  theme_toggle = { "everforest", "everforest_light" },
  theme = "everforest", -- default theme
  transparency = true,

}

M.mappings = require "custom.mappings"
M.plugins = require "custom.plugins"


return M
