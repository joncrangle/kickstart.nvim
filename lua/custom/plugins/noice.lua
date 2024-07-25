return {
  {
    'rcarriga/nvim-notify',
    event = 'VimEnter',
    opts = {
      background_colour = '#000000',
    },
  },
  {
    'folke/noice.nvim',
    lazy = true,
    event = 'VimEnter',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
        signature = { auto_open = false },
      },
      status = {
        lsp_progress = { event = 'lsp', kind = 'progress' },
      },
      routes = {
        -- Ignore the typical vim change messages
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '; after #%d+' },
              { find = '; before #%d+' },
              { find = '%d fewer lines' },
              { find = '%d more lines' },
            },
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'lsp',
            kind = 'progress',
          },
          opts = { skip = true },
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        lsp_doc_border = true,
        long_message_to_split = true,
      },
    },
    keys = {
      {
        '<leader>nl',
        function()
          require('noice').cmd 'last'
        end,
        desc = '[N]oice [L]ast',
      },
      {
        '<leader>nh',
        function()
          require('noice').cmd 'history'
        end,
        desc = '[N]oice [H]istory',
      },
      {
        '<leader>nd',
        function()
          require('noice').cmd 'dismiss'
        end,
        desc = '[N]oice [D]ismiss all',
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
