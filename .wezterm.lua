local wezterm = require("wezterm")

function scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        return "Catppuccin Frappe"
    else
        return "Catppuccin Frappe"
    end
end

return {
    color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
    font_size = 13,
    -- line_height = 1,
    font = wezterm.font_with_fallback({
        { family = "FantasqueSansM Nerd Font", scale = 1.1, weight = "Medium" },
    }),
    -- enable_tab_bar = false,
    leader = { key = "a", mods = "CTRL" },
    window_decorations = "NONE",
    window_background_opacity = 0.9,
    hide_tab_bar_if_only_one_tab = true,
    keys = {
        { key = "a", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },
        { key = "1", mods = "CTRL",        action = wezterm.action({ SendString = "\x06\x31" }) },
        { key = "2", mods = "CTRL",        action = wezterm.action({ SendString = "\x06\x32" }) },
        { key = "3", mods = "CTRL",        action = wezterm.action({ SendString = "\x06\x33" }) },
        { key = "4", mods = "CTRL",        action = wezterm.action({ SendString = "\x06\x34" }) },
        { key = "5", mods = "CTRL",        action = wezterm.action({ SendString = "\x06\x35" }) },
        { key = "6", mods = "CTRL",        action = wezterm.action({ SendString = "\x06\x36" }) },
        { key = "-", mods = "LEADER",      action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
        {
            key = "\\",
            mods = "LEADER",
            action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
        },
        { key = "s", mods = "LEADER",       action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
        { key = "v", mods = "LEADER",       action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
        { key = "o", mods = "LEADER",       action = "TogglePaneZoomState" },
        { key = "z", mods = "LEADER",       action = "TogglePaneZoomState" },
        { key = "c", mods = "LEADER",       action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
        { key = "h", mods = "LEADER",       action = wezterm.action({ ActivatePaneDirection = "Left" }) },
        { key = "j", mods = "LEADER",       action = wezterm.action({ ActivatePaneDirection = "Down" }) },
        { key = "k", mods = "LEADER",       action = wezterm.action({ ActivatePaneDirection = "Up" }) },
        { key = "l", mods = "LEADER",       action = wezterm.action({ ActivatePaneDirection = "Right" }) },
        { key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
        { key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
        { key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
        { key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
        { key = "1", mods = "LEADER",       action = wezterm.action({ ActivateTab = 0 }) },
        { key = "2", mods = "LEADER",       action = wezterm.action({ ActivateTab = 1 }) },
        { key = "3", mods = "LEADER",       action = wezterm.action({ ActivateTab = 2 }) },
        { key = "4", mods = "LEADER",       action = wezterm.action({ ActivateTab = 3 }) },
        { key = "5", mods = "LEADER",       action = wezterm.action({ ActivateTab = 4 }) },
        { key = "6", mods = "LEADER",       action = wezterm.action({ ActivateTab = 5 }) },
        { key = "7", mods = "LEADER",       action = wezterm.action({ ActivateTab = 6 }) },
        { key = "8", mods = "LEADER",       action = wezterm.action({ ActivateTab = 7 }) },
        { key = "9", mods = "LEADER",       action = wezterm.action({ ActivateTab = 8 }) },
        { key = "&", mods = "LEADER|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
        { key = "d", mods = "LEADER",       action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
        { key = "x", mods = "LEADER",       action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
    },
}
