local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
sbar.default({
	background = {
		height = 28,
		corner_radius = 9,
		border_width = 2,
		border_color = colors.bg2,
		image = {
			corner_radius = 9,
			border_color = colors.lightblack,
			border_width = 1,
		},
	},
	icon = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Bold"],
			size = 14.0,
		},
		color = colors.dirty_white,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
		background = { image = { corner_radius = 9 } },
	},
	label = {
		font = {
			family = settings.font.text,
			style = settings.font.style_map["Light"],
			size = 13.0,
		},
		color = colors.dirty_white,
		padding_left = settings.paddings,
		padding_right = settings.paddings,
	},
	popup = {
		background = {
			border_width = 2,
			corner_radius = 9,
			border_color = colors.popup.border,
			color = colors.popup.bg,
			shadow = { drawing = true },
		},
		blur_radius = 50,
	},
	padding_left = 5,
	padding_right = 5,
	scroll_texts = true,
	updates = "on",
})
