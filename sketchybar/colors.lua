return {
	black = 0xff181926, -- base
	white = 0xffcad3f5, -- text
	red = 0xffed8796,
	green = 0xffa6da95,
	blue = 0xff8aadf4,
	yellow = 0xffeed49f,
	orange = 0xfff5a97f,
	magenta = 0xffc6a0f6,
	purple = 0xffc6a0f6, -- used instead of lavender
	grey = 0xff5b6078, -- surface2
	dirty_white = 0xc8cad3f5, -- text with alpha
	lightblack = 0x8a1e2030, -- surface0 with alpha
	transparent = 0x00000000,
	try = 0xff1e2030, -- surface0
	try2 = 0xff24273a, -- base
	try3 = 0xff363a4f, -- mantle
	try_border = 0xff6e738d, -- overlay0
	try4 = 0xff1e1e2e, -- almost same as try

	bar = {
		bg = 0xf10f111a, -- crust with alpha
		border = 0xff363a4f, -- mantle
	},
	popup = {
		bg = 0xc024273a, -- base with alpha
		border = 0xffc6a0f6 -- lavender
	},
	bg1 = 0xff24273a, -- base
	bg2 = 0xff363a4f, -- mantle

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then return color end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
