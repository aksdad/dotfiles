-- [[ Basic Keymaps ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ User Commands ]]
vim.api.nvim_create_user_command("ShowNotifications", function()
    Snacks.notifier.show_history()
end, { desc = "Show notification history" })

vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
    else
        vim.g.disable_autoformat = true
    end
end, { desc = "Disable autoformat-on-save", bang = true })

vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
end, { desc = "Re-enable autoformat-on-save" })


local M = {}
M.set_lsp_keymaps = function(event)
    local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end
    map("gd", function() Snacks.picker.lsp_definitions() end, "[G]oto [D]efinition")
    map("gr", function() Snacks.picker.lsp_references() end, "[G]oto [R]eferences")
    map("gI", function() Snacks.picker.lsp_implementations() end, "[G]oto [I]mplementation")
    map("<leader>D", function() Snacks.picker.lsp_type_definitions() end, "Type [D]efinition")
    map("<leader>ds", function() Snacks.picker.lsp_symbols() end, "[D]ocument [S]ymbols")
    map("<leader>ws", function() Snacks.picker.lsp_workspace_symbols() end, "[W]orkspace [S]ymbols")
    map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
end

M.set_gitsigns_keymaps = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
        if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
        else
            gitsigns.nav_hunk('next')
        end
    end, { desc = 'Jump to next git [c]hange' })

    map('n', '[c', function()
        if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
        else
            gitsigns.nav_hunk('prev')
        end
    end, { desc = 'Jump to previous git [c]hange' })

    -- Actions
    -- visual mode
    map('v', '<leader>hs', function()
        gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
    end, { desc = 'stage git hunk' })
    map('v', '<leader>hr', function()
        gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
    end, { desc = 'reset git hunk' })
    -- normal mode
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
    map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
    map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    map('n', '<leader>hD', function()
        gitsigns.diffthis('@')
    end, { desc = 'git [D]iff against last commit' })
    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
end

return M
