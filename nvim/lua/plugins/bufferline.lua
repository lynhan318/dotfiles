return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
        vim.opt.termguicolors = true

        local bufferline = require("bufferline")

        bufferline.setup({
            options = {
                style_preset = bufferline.style_preset.minimal,
            },
        })
    end,
}
