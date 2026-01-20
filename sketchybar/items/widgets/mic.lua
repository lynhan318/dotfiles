local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

local popup_width = 250

local mic_icon = sbar.add("item", "widgets.mic1", {
	position = "right",
	padding_right = -1,
	icon = {
		width = 0,
		align = "left",
		color = colors.grey,
		font = {
			style = settings.font.style_map["Regular"],
			size = 14.0,
		},
	},
	label = {
		width = 25,
		align = "left",
		string = icons.mic.on,
		font = {
			style = settings.font.style_map["Regular"],
			size = 14.0,
		},
	},
})

local mic_bracket = sbar.add("bracket", "widgets.mic.bracket", {
	mic_icon.name,
}, {
	background = {
		color = colors.bg2,
		border_color = colors.bg1,
		border_width = 2,
	},
	popup = { align = "center" },
})

sbar.add("item", "widgets.mic.padding", {
	position = "right",
	width = settings.group_paddings,
})

local current_mic_device = "None"
local function mic_toggle_details(env)
	if env.BUTTON == "right" then
		sbar.exec("open /System/Library/PreferencePanes/Sound.prefpane")
		return
	end

	mic_bracket:set({ popup = { drawing = "toggle" } })

	sbar.exec("SwitchAudioSource -t input -c", function(result)
		current_mic_device = result:sub(1, -2)
		sbar.exec("SwitchAudioSource -a -t input", function(available)
			current = current_mic_device
			local color = colors.grey
			local counter = 0

			for device in string.gmatch(available, "[^\r\n]+") do
				local color = colors.grey
				if current == device then
					color = colors.white
				end
				sbar.add("item", "mic.device." .. counter, {
					position = "popup." .. mic_bracket.name,
					width = popup_width,
					align = "center",
					label = { string = device, color = color },
					click_script = 'SwitchAudioSource -t input -s "'
						.. device
						.. '" && sketchybar --set /mic.device\\.*/ label.color='
						.. colors.grey
						.. " --set $NAME label.color="
						.. colors.white,
				})
				counter = counter + 1
			end
		end)
	end)
end

local function mic_collapse_details()
	local drawing = mic_bracket:query().popup.drawing == "on"
	if not drawing then
		return
	end
	mic_bracket:set({ popup = { drawing = false } })
	sbar.remove("/mic.device\\.*/")
end

mic_icon:subscribe("mouse.clicked", mic_toggle_details)
mic_icon:subscribe("mouse.exited.global", mic_collapse_details)
