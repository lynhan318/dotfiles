return {
	{
		"RRethy/base16-nvim",
		priority = 1000,
		config = function()
			require('base16-colorscheme').setup({
				base00 = '#232a2e',
				base01 = '#232a2e',
				base02 = '#81847b',
				base03 = '#81847b',
				base04 = '#c4c9bd',
				base05 = '#fcfff8',
				base06 = '#fcfff8',
				base07 = '#fcfff8',
				base08 = '#ffaf9f',
				base09 = '#ffaf9f',
				base0A = '#bbd397',
				base0B = '#9ce695',
				base0C = '#f0ffd8',
				base0D = '#bbd397',
				base0E = '#e2f9bf',
				base0F = '#e2f9bf',
			})

			vim.api.nvim_set_hl(0, 'Visual', {
				bg = '#81847b',
				fg = '#fcfff8',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Statusline', {
				bg = '#bbd397',
				fg = '#232a2e',
			})
			vim.api.nvim_set_hl(0, 'LineNr', { fg = '#81847b' })
			vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#f0ffd8', bold = true })

			vim.api.nvim_set_hl(0, 'Statement', {
				fg = '#e2f9bf',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Keyword', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Repeat', { link = 'Statement' })
			vim.api.nvim_set_hl(0, 'Conditional', { link = 'Statement' })

			vim.api.nvim_set_hl(0, 'Function', {
				fg = '#bbd397',
				bold = true
			})
			vim.api.nvim_set_hl(0, 'Macro', {
				fg = '#bbd397',
				italic = true
			})
			vim.api.nvim_set_hl(0, '@function.macro', { link = 'Macro' })

			vim.api.nvim_set_hl(0, 'Type', {
				fg = '#f0ffd8',
				bold = true,
				italic = true
			})
			vim.api.nvim_set_hl(0, 'Structure', { link = 'Type' })

			vim.api.nvim_set_hl(0, 'String', {
				fg = '#9ce695',
				italic = true
			})

			vim.api.nvim_set_hl(0, 'Operator', { fg = '#c4c9bd' })
			vim.api.nvim_set_hl(0, 'Delimiter', { fg = '#c4c9bd' })
			vim.api.nvim_set_hl(0, '@punctuation.bracket', { link = 'Delimiter' })
			vim.api.nvim_set_hl(0, '@punctuation.delimiter', { link = 'Delimiter' })

			vim.api.nvim_set_hl(0, 'Comment', {
				fg = '#81847b',
				italic = true
			})

			local current_file_path = vim.fn.stdpath("config") .. "/lua/plugins/dankcolors.lua"
			if not _G._matugen_theme_watcher then
				local uv = vim.uv or vim.loop
				_G._matugen_theme_watcher = uv.new_fs_event()
				_G._matugen_theme_watcher:start(current_file_path, {}, vim.schedule_wrap(function()
					local new_spec = dofile(current_file_path)
					if new_spec and new_spec[1] and new_spec[1].config then
						new_spec[1].config()
						print("Theme reload")
					end
				end))
			end
		end
	}
}
