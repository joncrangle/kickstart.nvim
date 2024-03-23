return {
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        disabled_filetypes = {
          'neo-tree',
          'Trouble',
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
