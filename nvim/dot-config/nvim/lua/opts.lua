vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.shiftwidth = 4   -- Number of spaces for indentation
vim.o.tabstop = 4      -- Number of spaces per tab
vim.o.relativenumber = true
vim.o.winborder = 'single'

-- [[ Diagnostic signs ]]
local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
