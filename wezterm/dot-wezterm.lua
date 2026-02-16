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

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
function get_appearance()
    if wezterm.gui then
        return wezterm.gui.get_appearance()
    end
    return "Dark"
end

function scheme_for_appearance(appearance)
    if appearance:find("Dark") then
        return "rose-pine"
    else
        return "rose-pine-dawn"
    end
end

local config = {
    color_scheme = scheme_for_appearance(get_appearance()),
    window_background_opacity = 0.95,
    macos_window_background_blur = 30,
    hide_tab_bar_if_only_one_tab = true,
    window_decorations = "RESIZE",
    keys = keys,
}

return config
