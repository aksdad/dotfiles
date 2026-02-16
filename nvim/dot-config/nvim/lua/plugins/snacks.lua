---@class snacks.notifier.Config
local notifier_config = {
    ---@type snacks.notifier.style
    style = "fancy",
    top_down = false, -- place notifications from top to bottom
}

return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            bufdelete = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            lazygit = {
                enabled = true,

            },
            notifier = { enabled = true, style = "fancy", top_down = false, margin = { bottom = 1 } },
            picker = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
        keys = {
            { "<leader>bd",       function() Snacks.bufdelete() end,          desc = "Delete Buffer" },
            { "<leader>sh",       function() Snacks.picker.help() end,        desc = "[S]earch [H]elp" },
            { "<leader>sk",       function() Snacks.picker.keymaps() end,     desc = "[S]earch [K]eymaps", },
            { "<leader>sf",       function() Snacks.picker.files() end,       desc = "[S]earch [F]iles", },
            { "<leader>ss",       function() Snacks.picker.pickers() end,     desc = "[S]earch [S]elect Picker", },
            { "<leader>sw",       function() Snacks.picker.grep_word() end,   desc = "[S]earch current [W]ord", },
            { "<leader>sg",       function() Snacks.picker.grep() end,        desc = "[S]earch by [G]rep", },
            { "<leader>sd",       function() Snacks.picker.diagnostics() end, desc = "[S]earch [D]iagnostics", },
            { "<leader>sr",       function() Snacks.picker.resume() end,      desc = "[S]earch [R]esume", },
            { "<leader>s.",       function() Snacks.picker.recent() end,      desc = "[S]earch Recent Files ('.' for repeat)", },
            { "<leader><leader>", function() Snacks.picker.buffers() end,     desc = "[ ] Find existing buffers", },
            { "<leader>/",        function() Snacks.picker.lines() end,       desc = "[/] Fuzzily search in current buffer", },
            {
                "<leader>s/",
                function()
                    local bufs = vim.api.nvim_list_bufs()
                    local dirs = {}
                    for _, buf in ipairs(bufs) do
                        if vim.api.nvim_buf_is_loaded(buf) then
                            local name = vim.api.nvim_buf_get_name(buf)
                            if name ~= "" then
                                table.insert(dirs, vim.fn.fnamemodify(name, ":p:h"))
                            end
                        end
                    end
                    Snacks.picker.grep({ dirs = dirs, title = "Live Grep in Open Files" })
                end,
                desc = "[S]earch [/] in Open Files",
            },
            { "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "[S]earch [N]eovim files" },
            { "\\",         function() Snacks.explorer() end,                                       desc = "Toggle Explorer" },
            { "<leader>gb", function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
            { "<leader>gl", function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
            { "<leader>gL", function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
            { "<leader>gs", function() Snacks.picker.git_status() end,                              desc = "Git Status" },
            { "<leader>gS", function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
            { "<leader>gd", function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
            { "<leader>gf", function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
            { "<leader>gu", function() Snacks.lazygit.open() end,                                   desc = "Lazygit" },
        },
    },
}
