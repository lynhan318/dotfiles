return {
  "kevinhwang91/nvim-ufo",
  version = false,
  event = { "VeryLazy", "InsertEnter" },
  dependencies = { "kevinhwang91/promise-async" },
  keys = {
    {
      "zM",
      function()
        require("ufo").closeAllFolds()
      end,
      desc = "Close all folds",
    },
    {
      "zR",
      function()
        require("ufo").openAllFolds()
      end,
      desc = "Open all folds",
    },
  },
  opts = {},
}
