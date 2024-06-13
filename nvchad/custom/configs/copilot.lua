local opts = {
	panel = {
		enabled = true,
		auto_refresh = false,
	},
	suggestion = {
		enabled = true,
		auto_trigger = true,
		debounce = 75,
		keymap = {
			accept = "<C-;>",
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
}
return opts
