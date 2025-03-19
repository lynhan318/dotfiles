return {
	black = 0xFF232634,
	white = 0xFFc6d0f5,
	red = 0xFFe78284,
	green = 0xFFa6d189,
	blue = 0xFF8caaee,
	yellow = 0xFFe5c890,
	orange = 0xFFef9f76,
	magenta = 0xFFC198FD,
	grey = 0xFFa5adce,
	transparent = 0x00000000,

	bar = {
		bg = 0x00FFFFFF,
		border = 0x00FFFFFF,
	},

	popup = {
		bg = 0x99000000,
		border = 0xFF24273A,
	},

	bg1 = 0xFF303446,
	bg2 = 0xFF292c3c,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00FFFFFF) | (math.floor(alpha * 255.0) << 24)
	end,
}
