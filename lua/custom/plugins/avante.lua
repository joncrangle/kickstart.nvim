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
          max_tokens = 2048,
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
    build = 'make',
    opts = {
      provider = 'qwen',
      vendors = {
        qwen = generate_vendor('qwen2.5-coder:7b-instruct'),
        deepseek = generate_vendor('deepseek-coder-v2:16b-lite-instruct-q4_K_M'),
      },
    }
  },
}
-- vim: ts=2 sts=2 sw=2 et
