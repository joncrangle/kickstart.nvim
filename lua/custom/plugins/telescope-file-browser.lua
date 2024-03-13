return {
  'nvim-telescope/telescope-file-browser.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  opts = {
    extensions = {
      file_browser = {
        display_stat = { date = true, size = false },
        sorting_strategy = 'ascending',
        layout_config = {
          horizontal = {
            prompt_position = 'top',
            preview_width = 0.4,
          },
        },
      },
    },
  },
  config = function(_, opts)
    require('telescope').setup(opts)
  end,
  keys = {
    { '<C-f>', '<cmd>Telescope file_browser<cr>', desc = '[F]ile explorer' },
  },
}
