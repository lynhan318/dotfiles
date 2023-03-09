return {
	["williamboman/mason.nvim"] = {
		override_options = {
			ensure_installed = {
				"lua-language-server",
				"stylua",
				"typescript-language-server",
				"css-lsp",
				"json-lsp",
				"html-lsp",
				"rust-analyzer",
				"svelte-language-server",
			},
		},
	},
	["neovim/nvim-lspconfig"] = {
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.plugins.lspconfig")
		end,
	},
	["jose-elias-alvarez/null-ls.nvim"] = {
		after = "nvim-lspconfig",
		config = function()
			require("custom.plugins.null-ls")
		end,
	},
	["nvim-tree/nvim-tree.lua"] = {
		override_options = {
			view = {
				adaptive_size = true,
				side = "left",
				width = 25,
				hide_root_folder = true,
				mappings = {
					-- list = {
					--   { key = "U", action = "dir_up" },
					--   { key = "C", action = "change_dir" },
					-- },
				},
			},
		},
	},
	["tpope/vim-surround"] = {},
	["phaazon/hop.nvim"] = {
		branch = "v2", -- optional but strongly recommended
		config = function()
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	},
	["rafamadriz/friendly-snippets"] = {},
	["mg979/vim-visual-multi"] = {
		branch = "master",
	},
	["lvimuser/lsp-inlayhints.nvim"] = {
		config = function()
			require("lsp-inlayhints").setup()
			vim.cmd([[hi LspInlayHint guifg=#5c6a72 guibg=NONE ]])
		end,
	},
	["utilyre/barbecue.nvim"] = {
		tag = "*",
		requires = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		after = "nvim-web-devicons", -- keep this if you're using NvChad
		config = function()
			require("barbecue").setup()
		end,
	},
}
