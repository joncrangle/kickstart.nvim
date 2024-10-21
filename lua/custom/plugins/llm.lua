local function generate_vendor(model)
  return {
    ['local'] = true,
    endpoint = '127.0.0.1:11434/v1',
    model = model,
    parse_curl_args = function(opts, code_opts)
      return {
        url = opts.endpoint .. '/chat/completions',
        headers = {
          ['Accept'] = 'application/json',
          ['Content-Type'] = 'application/json',
        },
        body = {
          model = opts.model,
          messages = require('avante.providers').copilot.parse_message(code_opts),
          max_tokens = 8192,
          stream = true,
        },
      }
    end,
    parse_response_data = function(data_stream, event_state, opts)
      require('avante.providers').openai.parse_response(data_stream, event_state, opts)
    end,
  }
end

return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    build = vim.fn.has 'win32' == 0 and 'make' or
        'pwsh.exe -NoProfile -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false',
    opts = {
      provider = 'qwen',
      vendors = {
        qwen = generate_vendor('qwen-coder:latest'),
        deepseek = generate_vendor('deepseek-coder:latest'),
      },
    }
  },
  {
    'olimorris/codecompanion.nvim',
    enabled = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'hrsh7th/nvim-cmp',
      'nvim-telescope/telescope.nvim',
    },
    cmd = {
      'CodeCompanion',
      'CodeCompanionChat',
      'CodeCompanionToggle',
      'CodeCompanionActions',
      'CodeCompanionAdd',
    },
    config = function()
      require('codecompanion').setup {
        display = {
          diff = {
            provider = 'mini_diff',
          },
        },
        strategies = {
          chat = {
            adapter = 'ollama',
          },
          inline = {
            adapter = 'ollama',
          },
          agent = {
            adapter = 'ollama',
          },
        },
        adapters = {
          ollama = function()
            return require('codecompanion.adapters').extend('ollama', {
              env = {
                url = '127.0.0.1:11434',
              },
              schema = {
                model = {
                  default = 'qwen-coder:latest',
                },
              },
            })
          end,
        },
      }
    end,
    keys = {
      { '<leader>a', '<cmd>CodeCompanionChat toggle<cr>', desc = '[C]odeCompanion',         mode = { 'n', 'v' } },
      { '<C-a>',     '<cmd>CodeCompanionActions<cr>',     desc = '[C]odeCompanion Actions', mode = { 'n', 'v', } },
      { 'ga',        '<cmd>CodeCompanionChat Add<cr>',    desc = '[C]odeCompanion Add',     mode = 'v' },
    },
  }
}
-- vim: ts=2 sts=2 sw=2 et
