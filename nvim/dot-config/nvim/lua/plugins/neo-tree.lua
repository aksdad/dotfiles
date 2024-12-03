return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      '3rd/image.nvim',
    },
    config = function()
      -- Set up Neo-tree options here if needed
      require('neo-tree').setup()

      -- Bind \ to toggle Neo-tree
      vim.keymap.set('n', '\\', ':Neotree toggle<CR>', { noremap = true, silent = true })
    end,
  },
}
