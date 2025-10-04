-- [[ Set Telescope Border Backgrounds ]]
vim.cmd [[
  highlight TelescopeNormal guibg=none
  highlight TelescopeBorder guibg=none guifg=none
  highlight TelescopePromptNormal guibg=none
  highlight TelescopePromptTitle guibg=none
  highlight TelescopePromptBorder guibg=none guifg=none
  highlight TelescopeResultsNormal guibg=none
  highlight TelescopePreviewNormal guibg=none
]]

return {
  -- {
  --   'folke/tokyonight.nvim',
  --   priority = 1000,
  --   init = function()
  --     vim.cmd.colorscheme 'tokyonight-moon'
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  --   opts = {
  --     transparent = true,
  --     style = 'moon',
  --     on_highlights = function(highlights, colors)
  --       highlights.LineNr = { fg = colors.fg_dark }
  --     end,
  --   },
  -- },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = {
          -- transparency = true,
        }
      })
      vim.cmd("colorscheme rose-pine")
    end,
  },
  {
    'xiyaowong/nvim-transparent',
    config = function()
      require('transparent').setup {
        enable = true,       -- Enable transparent mode
        extra_groups = {     -- Groups to clear for transparency
          'NormalFloat',     -- Floating windows
          'NvimTreeNormal',  -- For Neo-tree or NvimTree
          'TelescopeNormal', -- For Telescope popup
          'TelescopeBorder',
          'TelescopePromptBorder',
          'TelescopePromptNormal',
          'TelescopePromptTitle',
          'TelescopeResultsNormal',
          'TelescopePreviewNormal',
        },
        exclude = {}, -- Groups not to clear
      }
    end,
  },
}
