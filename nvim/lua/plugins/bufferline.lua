return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    after = "catppuccin",
    config = function()
        require("bufferline").setup {
            highlights = require("catppuccin.groups.integrations.bufferline").get {
                styles = { "italic", "bold" },
            },
        }
    end,
}
