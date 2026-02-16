local blink_icon_block = {
    text = function(ctx)
        if ctx.source_name ~= "Path" then
            return (require("lspkind").symbol_map[ctx.kind] or "") .. ctx.icon_gap
        end

        local is_unknown_type = vim.tbl_contains(
            { "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
        local mini_icon, _ = require("mini.icons").get(
            is_unknown_type and "os" or ctx.item.data.type,
            is_unknown_type and "" or ctx.label
        )

        return (mini_icon or ctx.kind_icon) .. ctx.icon_gap
    end,

    highlight = function(ctx)
        if ctx.source_name ~= "Path" then return ctx.kind_hl end

        local is_unknown_type = vim.tbl_contains(
            { "link", "socket", "fifo", "char", "block", "unknown" }, ctx.item.data.type)
        local mini_icon, mini_hl = require("mini.icons").get(
            is_unknown_type and "os" or ctx.item.data.type,
            is_unknown_type and "" or ctx.label
        )
        return mini_icon ~= nil and mini_hl or ctx.kind_hl
    end,
}

return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({ async = true, lsp_format = "fallback" })
                end,
                mode = "",
                desc = "[F]ormat buffer",
            },
        },
        opts = {
            format_on_save = function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_format = "fallback" }
            end,
            formatters_by_ft = {
                lua = {},
            },
        },
    },
    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        version = '1.*',
        dependencies = { "rafamadriz/friendly-snippets", "onsails/lspkind.nvim" },
        opts = {
            completion = {
                documentation = { auto_show = true },
                menu = { draw = { components = { kind_icon = blink_icon_block } } }
            },
            signature = { enabled = true },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate'
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
        opts = {},
    },
    {
        "chrisgrieser/nvim-origami",
        event = "VeryLazy",
        opts = {},
        init = function()
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
        end,
    },
}
