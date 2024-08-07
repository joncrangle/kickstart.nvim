return {
  'm4xshen/hardtime.nvim',
  dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
  cmd = 'Hardtime',
  -- event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    enabled = false,
  },
  enabled = true,
  keys = {
    {
      '<leader>th',
      '<cmd>Hardtime toggle<cr>',
      desc = '[T]oggle [H]ardtime',
    },
    {
      '<leader>dh',
      '<cmd>Hardtime report<cr>',
      desc = '[D]isplay [H]ardtime report',
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
