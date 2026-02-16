return {
    {
        "folke/which-key.nvim",
        event = "VimEnter",
        opts = {
            icons = {
                mappings = true,
                keys = {},
            },
            spec = {
                { "<leader>c", group = "[C]ode",       mode = { "n", "x" } },
                { "<leader>d", group = "[D]ocument" },
                { "<leader>r", group = "[R]ename" },
                { "<leader>s", group = "[S]earch" },
                { "<leader>w", group = "[W]orkspace" },
                { "<leader>t", group = "[T]oggle" },
                { "<leader>h", group = "Git [H]unk",   mode = { "n", "v" } },
                { "<leader>g", group = "[G]it Picker", mode = { "n", "v" } },
            },
        },
    },
    {
        "folke/todo-comments.nvim",
        event = "VimEnter",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = { signs = false },
        keys = {
            { "<leader>st", function() Snacks.picker.todo_comments() end,                                          desc = "Todo" },
            { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
        },
    },
    {
        "rmagatti/auto-session",
        lazy = false,
        opts = {
            suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        },
    }
}
