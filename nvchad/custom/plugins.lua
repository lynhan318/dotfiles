local overrides = require("custom.configs.overrides")
---@type NvPluginSpec[]
local plugins = { -- Override plugin definition options
	{
		"neovim/nvim-lspconfig",
		dependencies = { -- format & linting
			{
				"nvimtools/none-ls.nvim",
				dependencies = {
					"nvimtools/none-ls-extras.nvim",
				},
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	}, -- overrde plugin configs
	{
		"nvim-treesitter/nvim-treesitter",
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
	{ "tpope/vim-surround", event = "BufReadPost" },
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
		opts = {
			close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			sort_case_insensitive = false, -- used when sorting files and directories in the tree
			open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
			window = {
				position = "left",
				width = 40,
				mapping_options = { noremap = true, nowait = true },
				mappings = {
					["<space>"] = {
						"toggle_node",
						nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
					},
					["<2-LeftMouse>"] = "open",
					["<cr>"] = "open",
					["S"] = "split_with_window_picker",
					["s"] = "vsplit_with_window_picker",
					["z"] = "close_node",
					["a"] = {
						"add",
						-- some commands may take optional config options, see `:h neo-tree-mappings` for details
						config = {
							show_path = "none", -- "none", "relative", "absolute"
						},
					},
					["n"] = "add_directory", -- also accepts the optional config.show_path option like "add".
					["d"] = "delete",
					["r"] = "rename",
					["c"] = "copy_to_clipboard",
					["m"] = "cut_to_clipboard",
					["t"] = "open_tabnew",
					["w"] = "open_with_window_picker",
					["p"] = "paste_from_clipboard",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
				},
			},
			nesting_rules = {},
		},
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
			-- config = function()
			-- 	require("configs.neotree")
			-- end,
		},
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
			vim.g.rust_clip_command = "xclip -selection clipboard"
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
			table.insert(M.sources, { name = "crates", "" })
			table.insert(M.sources, { name = "copilot", group_index = 2 })
			return M
		end,
	},
	{
		"mg979/vim-visual-multi",
		branch = "master",
		event = "BufReadPost",
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = false,
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<C-l>",
						accept_word = false,
						accept_line = false,
						next = "<M-]>",
						prev = "<M-[>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					rs = true,
					javascript = true,
					typescript = true,
					typescriptreact = true,
					javascriptreact = true,
					svelte = true,
					css = true,
					scss = true,
					json = true,
					markdown = true,
					["*"] = false,
				},
				copilot_node_command = "node", -- Node.js version must be > 18.x
				server_opts_overrides = {},
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				["*"] = { { "prettierd" } },
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
}

return plugins
