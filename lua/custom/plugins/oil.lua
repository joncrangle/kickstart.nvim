return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
  keys = {
    {
      '<leader>-',
      '<cmd>Oil<cr>',
      desc = 'Open parent directory in oil.nvim',
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
