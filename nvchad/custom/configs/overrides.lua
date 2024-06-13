local M = {}

M.treesitter = {
	ensure_installed = {
		"vim",
		"lua",
		"html",
		"css",
		"typescript",
		"svelte",
		"javascript",
		"c",
		"markdown",
		"rust",
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ic"] = "@conditional.inner",
				["ac"] = "@conditional.outer",
				["il"] = "@loop.inner",
				["al"] = "@loop.outer",
				["ib"] = "@block.inner",
				["ab"] = "@block.outer",
			},
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>", -- blockwise
			},
			include_surrounding_whitespace = true,
		},
	},
	indent = {
		enable = true,
		disable = {
			"python",
		},
	},
}

M.mason = {
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
}

-- git support in nvimtree

return M
