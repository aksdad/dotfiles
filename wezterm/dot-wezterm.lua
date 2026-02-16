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

local function opacity_for_appearance(appearance)
    if appearance:find("Dark") then
        return 0.95
    else
        return 1
    end
end

-- Cache file for theme
local theme_cache_file = os.getenv("HOME") .. "/.cache/share/theme"

-- Function to write theme to cache
local function write_theme_to_cache(appearance)
    local theme = "dark"
    if appearance:find("Light") then
        theme = "light"
    end

    -- Create directory if it doesn't exist
    local cache_dir = os.getenv("HOME") .. "/.cache/share"
    os.execute("mkdir -p " .. cache_dir)

    -- Write theme to cache file
    local file = io.open(theme_cache_file, "w")
    if file then
        file:write(theme)
        file:close()
    end
end

-- Write initial theme on config load
write_theme_to_cache(get_appearance())

local config = {
    color_scheme = scheme_for_appearance(get_appearance()),
    window_background_opacity = opacity_for_appearance(get_appearance()),
    macos_window_background_blur = 30,
    hide_tab_bar_if_only_one_tab = true,
    window_decorations = "RESIZE",
    keys = keys,
}

-- Update theme cache when window config changes
wezterm.on("window-config-reloaded", function(window, pane)
    local appearance = get_appearance()
    write_theme_to_cache(appearance)
end)

return config
