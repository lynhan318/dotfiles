local M = {}

M.custom = {
	i = {
		["ww"] = {
			"<ESC>:w<CR>",
			"write and escape",
			opts = {
				nowait = true,
			},
		},
		["<C-h>"] = {
			"<Left>",
			"move left",
		},
		["<C-l>"] = {
			"<Right>",
			"move right",
		},
		["jk"] = {
			"<ESC>",
			"escape insert mode",
			opts = {
				nowait = true,
			},
		},
	},
	n = {
		["S"] = {
			":%s//g<Left><Left>",
		},
		["<leader>1"] = { "1gt", "goto tab 1", nowait = true },
		["<leader>2"] = { "2gt", "goto tab 2", nowait = true },
		["<leader>3"] = { "3gt", "goto tab 3", nowait = true },
		["<leader>4"] = { "4gt", "goto tab 4", nowait = true },
		[";"] = {
			":",
			"enter cmdline",
			opts = {
				nowait = true,
			},
		},
		["<leader>x"] = {
			function()
				require("nvchad_ui.tabufline").close_buffer()
			end,
			"close buffer",
		},
	},
}

M.telescope = {
	plugin = true,
	i = {
		["<C-q>"] = {
			function()
				local actions = require("telescope.actions")
				actions.smart_send_to_qflist()
				actions.open_qflist()
			end,
			"send select file to quick and open",
		},
	},
}

return M
