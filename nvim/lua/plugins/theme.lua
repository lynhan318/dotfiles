return function()
	local cmd = vim.cmd
	cmd("syntax on")
	cmd("set termguicolors")
	cmd("set background=dark")

	-- sonokai theme
	-- cmd 'colorscheme sonokai'
	-- vim.g.sonokai_style = 'maia'
	-- vim.g.sonokai_enable_italic = 0
	-- vim.g.sonokai_disable_italic_comment = 1

	-- everforest theme
	vim.g.everforest_background = "soft"
	vim.g.everforest_better_performance = 1
	vim.g.everforest_enable_italic = 1
	vim.g.everforest_disable_italic_comment = 0
	vim.g.everforest_transparent_background = 1
	cmd("colorscheme everforest")
	-- tokyonighit
	-- cmd 'set background=dark'
	-- cmd 'set termguicolors'
	-- cmd 'colorscheme tokyonight'
end
