local settings = require("settings")
local colors = require("colors")
local icons = require("icons")

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

local cal = sbar.add("item", "calendar", {
	icon = {
		color = colors.white,
		padding_left = 8,
		font = {
			style = settings.font.style_map["Regular"],
			size = 12.0,
		},
	},
	label = {
		color = colors.white,
		padding_right = 8,
		width = 18,
		align = "right",
		font = { family = settings.font.numbers, size = 12.0 },
	},
	position = "right",
	update_freq = 1,
	padding_left = 1,
	padding_right = 1,
	click_script = "open -a 'Calendar'",
})

-- Double border for calendar using a single item bracket
sbar.add("bracket", { cal.name }, {
	background = {
		color = colors.bg2,
		border_width = 2,
		border_color = colors.bg1,
	},
})

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
	cal:set({ icon = icons.calendar .. " " .. os.date("%a. %d %b.") })
end)
