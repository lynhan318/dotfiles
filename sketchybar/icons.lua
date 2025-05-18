local settings = require("settings")

local icons = {
	sf_symbols = {
		plus = "􀅼",
		loading = "􀖇",
		apple = "􀣺",
		gear = "􀍟",
		cpu = "􀫥",
		clipboard = "􀉄",
		calendar = "􀉉",
		network = "􀤆",

		weather = {
			sunny = "􀆭",
			partly = "􀇔",
			cloudy = "􀇂",
			rainy = "􀇆",
			snowy = "􀇎",
			clear = "􀇀",
			foggy = "􀇊",
			stormy = "􀇞",
		},

		brew = {
			full = "􀐛",
			empty = "􀐚",
		},

		switch = {
			on = "􁏮",
			off = "􁏯",
		},

		mic = {
			on = "􀊰",
			muted = "􀊲",
		},

		volume = {
			_100 = "􀊩",
			_66 = "􀊧",
			_33 = "􀊥",
			_10 = "􀊡",
			_0 = "􀊣",
		},

		battery = {
			_100 = "􀛨",
			_75 = "􀺸",
			_50 = "􀺶",
			_25 = "􀛩",
			_0 = "􀛪",
			charging = "􀢋",
		},

		wifi = {
			upload = "􀄨",
			download = "􀄩",
			connected = "􀙇",
			disconnected = "􀙈",
			router = "􁓤",
		},

		media = {
			back = "􀊊",
			forward = "􀊌",
			play_pause = "􀊈",
		},

		space_indicator = {
			on = "󰄯",
			off = "󰄰",
		},

		ramicons = {
			swap = "󰁄",
			ram = "󰍛",
		},
	},

	-- Alternative NerdFont icons
	nerdfont = {
		plus = "",
		loading = "",
		apple = "",
		gear = "",
		cpu = "",
		clipboard = "Missing Icon",
		calendar = "􀉉",
		network = "􀤆",

		weather = {
			sunny = "􀆭",
			partly = "􀇔",
			cloudy = "􀇂",
			rainy = "􀇆",
			snowy = "􀇎",
			clear = "􀇀",
			foggy = "􀇊",
			stormy = "􀇞",
		},

		brew = {
			full = "􀐛",
			empty = "􀐚",
		},

		switch = {
			on = "󱨥",
			off = "󱨦",
		},

		mic = {
			on = "􀊰",
			muted = "􀊲",
		},

		volume = {
			_100 = "",
			_66 = "",
			_33 = "",
			_10 = "",
			_0 = "",
		},

		battery = {
			_100 = "",
			_75 = "",
			_50 = "",
			_25 = "",
			_0 = "",
			charging = "",
		},

		wifi = {
			upload = "",
			download = "",
			connected = "󰖩",
			disconnected = "󰖪",
			router = "Missing Icon",
		},

		media = {
			back = "",
			forward = "",
			play_pause = "",
		},

		space_indicator = {
			on = "󰄯",
			off = "󰄰",
		},

		ramicons = {
			swap = "󰁄",
			ram = "󰍛",
		},
	},
}

if not (settings.icons == "NerdFont") then
	return icons.sf_symbols
else
	return icons.nerdfont
end
