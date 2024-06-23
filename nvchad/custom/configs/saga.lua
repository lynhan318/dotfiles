local opts = {
	lightbulb = {
		enable = false,
	},
	use_saga_dianostic_sign = true,

	code_action_prompt = {
		enable = true,
		sign = true,
		virtual_text = false,
	},
	symbol_in_winbar = {
		enable = true,
		separator = " › ",
		show_file = true,
		folder_level = 1,
		color_mode = true,
		delay = 300,
	},
}
return opts
