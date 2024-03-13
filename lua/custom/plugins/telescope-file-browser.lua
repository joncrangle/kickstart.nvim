return {
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  keys = {
    { '<C-f>', '<cmd>Telescope file_browser<cr>', desc = '[F]ile explorer' },
  },
}
