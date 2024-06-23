local overrides = require("custom.configs.overrides")
---@type NvPluginSpec[]
local plugins = { -- Override plugin definition options
	{
		"neovim/nvim-lspconfig",
		config = function()
			-- require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	}, -- overrde plugin configs
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		opts = overrides.treesitter,
	},
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},
	{ "rafamadriz/friendly-snippets" },
	{
		"mg979/vim-visual-multi",
		branch = "master",
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
			vim.g.rust_clip_command = "pbcopy"
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = "neovim/nvim-lspconfig",
		opts = function()
			return require("custom.configs.rust-tools")
		end,
		config = function(_, opts)
			require("rust-tools").setup(opts)
		end,
	},
	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		config = function(_, opts)
			local crates = require("crates")
			crates.setup(opts)
			crates.show()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		opts = function()
			local M = require("plugins.configs.cmp")
			return M
		end,
	},
	{
		"mg979/vim-visual-multi",
		branch = "master",
		event = "BufReadPost",
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufWritePre" },
		config = function()
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					-- try_lint without arguments runs the linters defined in `linters_by_ft`
					-- for the current filetype
					require("lint").linters_by_ft = {
						javascript = { "biomejs" },
						typescript = { "biomejs" },
						typescriptreact = { "biomejs" },
						javascriptreact = { "biomejs" },
						css = { "biomejs" },
						json = { "biomejs" },
					}
					require("lint").try_lint()
				end,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt" },
				typescript = { "biome" },
				javascript = { "biome" },
				typescriptreact = { "biome" },
				javascriptreact = { "biome" },
				css = { "biome" },
				["*"] = { "prettierd" },
			},
			format_on_save = { timeout_ms = 500, lsp_fallback = false },
		},
	},
	{
		"RRethy/vim-illuminate",
		event = "BufReadPost",
		config = function()
			require("custom.configs.illuminate")
		end,
	},
	{
		"stevearc/oil.nvim",
		opts = {
			default_file_explorer = true,
			float = {
				-- Padding around the floating window
				padding = 10,
				max_width = 300,
				max_height = 300,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
				preview_split = "auto",
				override = function(conf)
					return conf
				end,
			},
		},
		keys = {
			{ "-", "<cmd>Oil --float<cr>", desc = "OilTree", mode = "n" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"mikavilpas/yazi.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		event = "VeryLazy",
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>-",
				function()
					require("yazi").yazi()
				end,
				desc = "Open the file manager",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				function()
					require("yazi").yazi(nil, vim.fn.getcwd())
				end,
				desc = "Open the file manager in nvim's working directory",
			},
		},
		---@type YaziConfig
		opts = {
			open_for_directories = false,
		},
	},
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- We'd like this plugin to load first out of the rest
		config = true, -- This automatically runs `require("luarocks-nvim").setup()`
	},
	{
		"tpope/vim-fugitive",
		lazy = false,
	},
	{
		"rmagatti/goto-preview",
		opts = require("custom.configs.preview"),
		keys = {
			{
				"gpd",
				"<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
				desc = "Preview Definition",
				mode = "n",
			},
			{
				"gpi",
				"<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
				desc = "Preview Implement",
				mode = "n",
			},
			{
				"gpD",
				"<cmd>lua require('goto-preview').close_all_win()<CR>",
				desc = "Delete All Preview",
				mode = "n",
			},
		},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = require("custom.configs.copilot"),
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		opts = require("custom.configs.saga"),
		cmd = "Lspsaga",
		keys = {
			{
				"ca",
				"<cmd>Lspsaga code_action<cr>",
				desc = "Code Action",
				mode = "n",
			},
		},
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
	},
	{
		"phaazon/hop.nvim",
		keys = {
			{ "f", "<cmd>HopChar1CurrentLine<cr>", desc = "Hop Char 1", mode = "n" },
			{ "F", "<cmd>HopChar2<cr>", desc = "Hop Char 2", mode = "n" },
		},
		branch = "v2", -- optional but strongly recommended
		config = function()
			require("hop").setup({
				keys = "etovxqpdygfblzhckisuran",
			})
		end,
	},
}

return plugins
