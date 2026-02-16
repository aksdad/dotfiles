vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- [[ Auto-switch theme based on system appearance ]]
-- When terminal reports background change (e.g., macOS dark/light mode)
vim.api.nvim_create_autocmd("OptionSet", {
    pattern = "background",
    desc = "Auto-switch colorscheme based on system appearance",
    group = vim.api.nvim_create_augroup("auto-theme-switch", { clear = true }),
    callback = function()
        if _G.apply_theme then
            apply_theme()
        end
    end,
})

-- [[ Periodic system appearance check for macOS ]]
-- This polls the system appearance every 5 seconds as a fallback
-- when OSC sequences don't come through (common with WezTerm)

if vim.uv.os_uname().sysname == "Darwin" then
    local timer = vim.uv.new_timer()
    local current_bg = vim.o.background

    timer:start(
        5000, -- Initial delay: 5 seconds
        5000, -- Repeat interval: 5 seconds
        vim.schedule_wrap(function()
            if _G.get_macos_appearance and _G.sync_theme_with_system then
                local appearance = get_macos_appearance()
                -- Only update if appearance actually changed
                if appearance and appearance ~= current_bg then
                    current_bg = appearance
                    sync_theme_with_system()
                end
            end
        end)
    )
end

-- [[ LSP Keymaps on Attach ]]
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        require('keymaps').set_lsp_keymaps(event)
    end,
})

-- [[ Pretty LSP progress for Snacks]]
---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params
            .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ("[%3d%%] %s%s"):format(
                        value.kind == "end" and 100 or value.percentage or 100,
                        value.title or "",
                        value.message and (" **%s**"):format(value.message) or ""
                    ),
                    done = value.kind == "end",
                }
                break
            end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and " "
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})
