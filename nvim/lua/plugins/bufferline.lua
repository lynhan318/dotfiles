return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  lazy = false,
  -- after = "everforest",
  config = function()
    require("bufferline").setup {}
  end,
}
