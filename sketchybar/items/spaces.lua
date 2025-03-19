local icons = require("icons")
local colors = require("colors")
local app_icons = require("helpers.app_icons")
local settings = require("settings")

function parse_string_to_table(s)
	local result = {}
	for line in s:gmatch("([^\n]+)") do
		table.insert(result, line)
	end
	return result
end

local file = io.popen("aerospace list-workspaces --all")
local result = file:read("*a")
file:close()

local workspaces = parse_string_to_table(result)
for i, workspace in ipairs(workspaces) do
	local space = sbar.add("item", "space." .. i, {
		icon = {
			font = { family = settings.font.numbers },
			string = workspace,
			padding_left = 15,
			padding_right = 12,
			color = colors.white,
			highlight_color = colors.red,
		},
		label = {
			color = colors.grey,
			highlight_color = colors.white,
			font = "sketchybar-app-font:Regular:18.0",
			y_offset = -1,
		},
		padding_right = 1,
		padding_left = 1,
		background = {
			color = colors.bg1,
			border_width = 1,
			height = 26,
			border_color = colors.black,
		},
		popup = { background = { border_width = 5, border_color = colors.black } },
	})

	space:subscribe("mouse.clicked", function(env)
		sbar.exec("aerospace workspace " .. workspace)
	end)

	space:subscribe("aerospace_workspace_change", function(env)
		local selected = env.FOCUSED_WORKSPACE == workspace
		space:set({
			icon = { highlight = selected },
			label = { highlight = selected },
			background = {
				border_color = selected and colors.red or colors.bg2,
				-- color = selected and colors.green or colors.bg2,
			},
		})
	end)
	-- Padding space
	sbar.add("space", "space.padding." .. i, {
		space = i,
		script = "",
		width = settings.group_paddings,
	})
end
