return {
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            on_attach = function(bufnr)
                require('keymaps').set_gitsigns_keymaps(bufnr)
            end,
        },
    },
}
