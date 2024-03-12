return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    {
      '<leader>x',
      function()
        require('trouble').toggle()
      end,
      desc = 'Toggle Trouble',
    },
  },
}
