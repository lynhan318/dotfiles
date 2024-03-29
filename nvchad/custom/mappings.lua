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
		["jk"] = {
			"<ESC>",
			"escape insert mode",
			opts = {
				nowait = true,
			},
		},
	},
	n = {
		["gp"] = {
			"<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
			"Goto Preview Definition",
			opts = { nowait = true },
		},
		["gq"] = {
			"<cmd>lua require('goto-preview').close_all_win()<CR>",
			"Close All Previews",
			opts = { nowait = true },
		},
		["S"] = {
			":%s//g<Left><Left>",
			"Search and replace",
			opts = {
				nowait = true,
			},
		},
		[";"] = {
			":",
			"enter cmdline",
			opts = {
				nowait = true,
			},
		},
		["<leader>j"] = { "<cmd> HopChar2 <CR>", "Hope auto jump" },
		["<leader>x"] = {
			function()
				require("nvchad_ui.tabufline").close_buffer()
			end,
			"close buffer",
		},
		["<C-b>"] = { "<cmd> Neotree toggle <CR>", "toggle neotree" },
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
M.dap = {
	n = {
		["<leader>db"] = {
			"<cmd>lua require'dap'.toggle_breakpoint()<CR>",
			"toggle breakpoint",
		},
		["<leader>dui"] = {
			function()
				require("dapui").toggle()
			end,
			"Open debugging sidebar",
		},
	},
}

return M
-- Quickfix override
-- configs/telescope.lua
-- mappings = {
--   i = {
--     ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
--   },
--   n = {
--     ["q"] = require("telescope.actions").close,
--     ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
--   },
-- },
--
