return {
    {
        "nvim-mini/mini.nvim",
        config = function()
            require("mini.ai").setup({ n_lines = 500 })
            require("mini.surround").setup()
            require("mini.pairs").setup()
            require("mini.icons").setup()
            -- Mock MiniIcons module for other plugins to detect mini.icons
            MiniIcons = require("mini.icons")
            local statusline = require("mini.statusline")
            statusline.setup({ use_icons = true })

            ---@diagnostic disable-next-line: duplicate-set-field
            statusline.section_location = function()
                return "%2l:%-2v"
            end
        end,
    },
}
