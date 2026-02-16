return {
    settings = {
        Lua = {
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = "4",
                },
            },
            completion = {
                callSnippet = "Replace",
            },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
            }
        },
    },
}
