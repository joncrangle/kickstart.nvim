return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'echasnovski/mini.nvim' },
    event = { 'BufReadPost', 'BufNewFile' },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = ' '
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = {
      options = {
        theme = 'auto',
        globalstatus = true,
        extensions = {
          'lazy',
          'mason',
          'neo-tree',
          'nvim-dap-ui',
          'oil',
          'quickfix',
          'trouble',
        },
        disabled_filetypes = { statusline = { 'dashboard', 'lazygit' } },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
