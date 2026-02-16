-- Function to apply theme based on system appearance
-- This is exposed globally so autocmds can use it
function _G.apply_theme()
    local bg = vim.o.background
    if bg == "dark" then
        vim.cmd("colorscheme rose-pine-main")
    else
        -- Default to dawn for light or unknown
        vim.cmd("colorscheme rose-pine-dawn")
    end
end

-- Function to detect macOS system appearance
-- Returns 'dark', 'light', or nil if unable to detect
function _G.get_macos_appearance()
    if vim.loop.os_uname().sysname ~= "Darwin" then
        return nil
    end

    if vim.fn.executable("defaults") == 0 then
        return nil
    end

    -- Check if Dark mode is enabled
    -- defaults read -g AppleInterfaceStyle returns "Dark" or errors if not set (light mode)
    local result = vim.fn.system({ "defaults", "read", "-g", "AppleInterfaceStyle" })
    local exit_code = vim.v.shell_error

    if exit_code == 0 and result:match("Dark") then
        return "dark"
    else
        return "light"
    end
end

-- Function to sync theme with system appearance
-- This sets vim.o.background which triggers the OptionSet autocmd
function _G.sync_theme_with_system()
    local appearance = get_macos_appearance()
    if appearance then
        vim.o.background = appearance
    end
end

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require("rose-pine").setup({
                styles = {
                    transparency = true,
                },
            })
            sync_theme_with_system()
            apply_theme()
        end,
    },
}
