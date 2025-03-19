local icons = require("icons")
local colors = require("colors")
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
			string = workspace,
			color = colors.white,
			highlight_color = colors.red,
		},
		label = { drawing = false },
		padding_left = 10,
		padding_right = 10,
		background = {
			height = 28,
			color = { alpha = 0 },
			border_color = { alpha = 0 },
			drawing = true,
		},
	})

	space:subscribe("mouse.clicked", function(env)
		sbar.exec("aerospace workspace " .. i)
	end)

	space:subscribe("aerospace_workspace_change", function(env)
		local selected = env.FOCUSED_WORKSPACE == workspace
		space:set({
			icon = { highlight = selected },
			label = { highlight = selected },
			background = { border_color = selected and colors.white or colors.bg2 },
		})
	end)
end
