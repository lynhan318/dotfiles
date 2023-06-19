local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- "folke/which-key.nvim",
	-- "folke/neodev.nvim",
	{ "nvim-tree/nvim-web-devicons", config = require("plugins.devicons") },
	-- Colorizer
	{ "norcalli/nvim-colorizer.lua", config = require("plugins.colorizer") },

	-- Comment
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{ "tpope/vim-commentary" },

	-- Git
	{ "tpope/vim-fugitive" },

	--  {'folke/trouble.nvim', dependencies = 'kyazdani42/nvim-web-devicons'}

	-- Surround
	{ "tpope/vim-surround" },
	{ "windwp/nvim-ts-autotag" },
	{ "jiangmiao/auto-pairs" },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = require("plugins.treesitter"),
	},
	{
		"romgrk/barbar.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = require("plugins.barbar"),
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = require("plugins.lualine"),
	},

	-- Snippets
	{
		"SirVer/ultisnips",
		dependencies = "honza/vim-snippets",
		config = require("plugins.ultisnip"),
	},

	-- Completion
	--  {'hrsh7th/nvim-compe', config = require 'plugins.compe'}
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-nvim-lsp-signature-help" },
	{ "hrsh7th/nvim-cmp", config = require("plugins.cmp") },
	{ "quangnguyen30192/cmp-nvim-ultisnips" },

	-- Smooth scrollw
	{ "psliwka/vim-smoothie" },
	{ "sainnhe/everforest", config = require("plugins.theme") },
	"simrat39/rust-tools.nvim",
	"rust-lang/rust.vim",
	-- LSP
	{
		"rmagatti/goto-preview",
		config = function()
			require("goto-preview").setup({})
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = require("plugins.null-ls"),
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "simrat39/rust-tools.nvim", "rust-lang/rust.vim" },
		config = require("plugins.lspconfig"),
	},
	{
		"saecki/crates.nvim",
		version = "v0.1.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup()
		end,
	},
	{ "nvim-lua/popup.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{ "terryma/vim-multiple-cursors" },
	--  {'mhartington/formatter.nvim', config = require 'plugins.prettier'},
	{ "cespare/vim-toml", branch = "main" },
	{ "othree/html5.vim" },
	{ "posva/vim-vue" },
	{
		"evanleck/vim-svelte",
		config = function()
			vim.g.svelte_preprocessors = "typescript"
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = require("plugins.neotree"),
	},
	{
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
			vim.keymap.set("n", "fw", "<cmd>:HopChar2<cr>")
			vim.keymap.set("n", "fe", "<cmd>:HopPattern<cr>")
		end,
	},
	-- {
	-- 	"chentoast/marks.nvim",
	-- 	config = function()
	-- 		require("marks").setup({})
	-- 	end,
	-- },
	{
		"voldikss/vim-floaterm",
		-- keys = {
		-- 	{ "<C-\\>", "<cmd>FloatermToggle<cr>" },
		-- 	{ "<C-\\>", "<cmd>FloatermToggle<cr>", { mode = "tnoremap", desc = "Floaterm" } },
		-- },
		config = function()
			vim.g.floaterm_wintype = "float"
			vim.g.floaterm_position = "bottomright"
			vim.g.floaterm_width = 0.6
			vim.g.floaterm_height = 0.5
			vim.g.floaterm_keymap_toggle = "<C-\\>"
		end,
	},
	-- install fzf
	{ "junegunn/fzf" },
	{ "junegunn/fzf.vim", config = require("plugins.fzf") },
	{
		"kevinhwang91/nvim-hlslens",
		config = function()
			require("hlslens").setup()
			local kopts = { noremap = true, silent = true }

			vim.api.nvim_set_keymap(
				"n",
				"n",
				[[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap(
				"n",
				"N",
				[[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
				kopts
			)
			vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
			vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

			vim.api.nvim_set_keymap("n", "<Leader>l", ":noh<CR>", kopts)
		end,
	},
	{
		"vuki656/package-info.nvim",
		dependencies = "MunifTanjim/nui.nvim",
		config = function()
			require("package-info").setup()
			vim.keymap.set({ "n" }, "<LEADER>ns", require("package-info").show, { silent = true, noremap = true })
			vim.keymap.set({ "n" }, "<LEADER>nc", require("package-info").hide, { silent = true, noremap = true })
		end,
	},
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	--  { 'sunjon/shade.nvim', config = require('plugins.shade') }
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				show_current_context = true,
				show_current_context_start = true,
				filetype_exclude = { "help", "txt", "norg", "md" },
				buftype_exclude = { "terminal", "nofile" },
			})
			vim.g.indent_blankline_char = "∘"
		end,
	},

	{
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = require("plugins.saga"),
	},
	{
		"xiyaowong/nvim-transparent",
		config = function()
			require("transparent").setup({
				enable = false, -- boolean: enable transparent
				extra_groups = {
					"NeoTreeFileIcon",
					"NeoTreeExpander",
				},
				exclude = {}, -- table: groups you don't want to clear
			})
		end,
	},
})
