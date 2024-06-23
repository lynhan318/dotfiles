local M = { "stevearc/dressing.nvim" }

function M.init()
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.select = function(...)
    require("lazy").load {
      plugins = { "dressing.nvim" },
    }
    return vim.ui.select(...)
  end
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.input = function(...)
    require("lazy").load {
      plugins = { "dressing.nvim" },
    }
    return vim.ui.input(...)
  end
end

function M.config()
  require("dressing").setup {
    input = {
      enable = true,
      border = "rounded",
      win_options = {
        -- No transparency for input window
        winblend = 0,
      },
    },
    select = {
      telescope = require("telescope.themes").get_dropdown {},
    },
    nui = {
      position = "50%",
      size = nil,
      relative = "editor",
      border = {
        style = "rounded",
      },
      buf_options = {
        swapfile = false,
        filetype = "DressingSelect",
      },
      win_options = {
        winblend = 0,
      },
      max_width = 80,
      max_height = 40,
      min_width = 40,
      min_height = 10,
    },
  }
end

return M
