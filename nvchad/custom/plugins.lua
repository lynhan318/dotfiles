local overrides = require("custom.configs.overrides")
---@type NvPluginSpec[]
local plugins = { -- Override plugin definition options
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	}, -- overrde plugin configs
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		opts = overrides.treesitter,
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},
	{
		"utilyre/barbecue.nvim",
		lazy = false,
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			require("barbecue").setup()
		end,
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
		"kevinhwang91/nvim-bqf",
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
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		opts = require("custom.configs.neotree"),
		keys = {
			{ "<C-b>", "<CMD>Neotree toggle<CR>", { desc = "Toggle neotree" } },
			{ ".", "<CMD>Neotree reveal<CR>", { desc = "Reveal neotree at current relative path" } },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			{
				"s1n7ax/nvim-window-picker",
				version = "2.*",
				config = function()
					require("window-picker").setup({
						filter_rules = {
							include_current_win = false,
							autoselect_one = true,
							-- filter using buffer options
							bo = {
								-- if the file type is one of following, the window will be ignored
								filetype = { "neo-tree", "neo-tree-popup", "notify" },
								-- if the buffer type is one of following, the window will be ignored
								buftype = { "terminal", "quickfix" },
							},
						},
					})
				end,
			},
		},
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
				-- ["*"] = { "prettierd" },
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
		opts = {},
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "NeoTree", mode = "n" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- We'd like this plugin to load first out of the rest
		config = true, -- This automatically runs `require("luarocks-nvim").setup()`
	},
	{
		"nvim-neorg/neorg",
		dependencies = { "luarocks.nvim" },
		lazy = false,
		build = ":Neorg sync-parsers",
		-- put any other flags you wanted to pass to lazy here!
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/notes",
								wow3 = "~/wow3",
							},
							default_workspace = "notes",
						},
					},
				},
			})

			vim.wo.foldlevel = 99
			vim.wo.conceallevel = 2
		end,
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
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}

return plugins
