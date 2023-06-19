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
M.nvimtree = {
	git = {
		enable = false,
	},

	renderer = {
		highlight_git = false,
		icons = {
			show = {
				git = false,
			},
		},
	},
}

return M
