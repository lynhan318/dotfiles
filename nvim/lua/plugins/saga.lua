return function()
	local saga = require("lspsaga")
	local keymap = vim.keymap.set

	-- saga.init_lsp_saga()

	saga.setup({
		symbol_in_winbar = {
			enable = true,
			separator = " ",
			hide_keyword = true,
			show_file = true,
			folder_level = 2,
			respect_root = false,
		},
	})
end
