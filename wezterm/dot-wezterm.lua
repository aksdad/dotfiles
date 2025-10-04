local wezterm = require("wezterm")

local keys = {
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {
        key = "LeftArrow",
        mods = "OPT",
        action = wezterm.action({ SendString = "\x1bb" }),
    },
    -- Make Option-Right equivalent to Alt-f; forward-word
    {
        key = "RightArrow",
        mods = "OPT",
        action = wezterm.action({ SendString = "\x1bf" }),
    },
}

local config = {
    color_scheme = "rose-pine-moon", -- tokyonight_moon
    window_background_opacity = 1,
    macos_window_background_blur = 40,
    hide_tab_bar_if_only_one_tab = true,
    window_decorations = "RESIZE",
    keys = keys,
}

return config
