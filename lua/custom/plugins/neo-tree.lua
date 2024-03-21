return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  opts = {},
  keys = {
    {
      '<C-f>',
      '<cmd>Neotree toggle<cr>',
      desc = '[F]ile explorer',
    },
  },
}
