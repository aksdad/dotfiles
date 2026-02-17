local wezterm = require("wezterm")
local act = wezterm.action
local sessions = wezterm.plugin.require(
    "https://github.com/abidibo/wezterm-sessions"
)

local keys = {
    -- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
    {
        key = "LeftArrow",
        mods = "OPT",
        action = act({ SendString = "\x1bb" }),
    },
    -- Make Option-Right equivalent to Alt-f; forward-word
    {
        key = "RightArrow",
        mods = "OPT",
        action = act({ SendString = "\x1bf" }),
    },
    {
        key = 'S',
        mods = 'CTRL|SHIFT',
        action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' },
    },
    {
        key = 'F',
        mods = 'CTRL|SHIFT',
        action = act.PaneSelect {
        },
    },
    {
        key = 'F',
        mods = 'CTRL|ALT|SHIFT',
        action = act.PaneSelect {
            mode = 'SwapWithActive',
        },
    },
    {
        key = 'W',
        mods = 'CTRL|SHIFT',
        action = act.PromptInputLine {
            description = 'Create / switch to workspace — enter name:',
            action = wezterm.action_callback(function(window, pane, line)
                -- line == nil if user pressed Esc / cancelled
                if line and line ~= "" then
                    -- create or switch to the named workspace
                    window:perform_action(act.SwitchToWorkspace { name = line }, pane)
                end
            end),
        },
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
    front_end = "WebGpu",
}
wezterm.on('update-right-status', function(window, _)
    window:set_right_status(window:active_workspace())
end)

-- Setup sessions
-- Optional: adds default keybindings and plugin configuration
-- ALT + s   → Save session
-- ALT + l   → Load session
-- ALT + r   → Restore session
-- CTRL+SHIFT + d → Delete session
-- CTRL+SHIFT + e → Edit session
-- ALT + a   → Toggle auto-save
-- ALT + f   → Fork session
sessions.apply_to_config(config, {
    -- Auto-save interval in seconds (default: 30)
    auto_save_interval_s = 30,
})

-- Update theme cache when window config changes
wezterm.on("window-config-reloaded", function(window, pane)
    local appearance = get_appearance()
    write_theme_to_cache(appearance)
end)

return config
