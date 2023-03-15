local plugins = {{"williamboman/mason.nvim"}, {
    "neovim/nvim-lspconfig",
    config = function()
        require("plugins.configs.lspconfig")
        require("custom.plugins.lspconfig")
    end
}, {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = "nvim-lspconfig",
    config = function()
        require("custom.plugins.null-ls")
    end
}, {"nvim-tree/nvim-tree.lua"}, {"tpope/vim-surround"}, {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    config = function()
        require("hop").setup({
            keys = "etovxqpdygfblzhckisuran"
        })
    end
}, {"rafamadriz/friendly-snippets"}, {
    "mg979/vim-visual-multi",
    branch = "master"
}, {
    "lvimuser/lsp-inlayhints.nvim",
    config = function()
        require("lsp-inlayhints").setup()
        vim.cmd([[hi LspInlayHint guifg=#5c6a72 guibg=NONE ]])
    end
}, {
    "utilyre/barbecue.nvim",
    -- tag = "*",
    requires = {"SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" -- optional dependency
    },
    dependencies = "nvim-web-devicons", -- keep this if you're using NvChad
    config = function()
        require("barbecue").setup()
    end
}}

return plugins