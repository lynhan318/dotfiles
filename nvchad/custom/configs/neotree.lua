local opts = {
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
			["o"] = "open",
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
			["p"] = "paste_from_clipboard",
			["q"] = "close_window",
			["R"] = "refresh",
			["?"] = "show_help",
		},
	},
	nesting_rules = {},
}
return opts
