return {
  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        bash = { 'shfmt' },
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        css = { { 'prettierd', 'prettier' } },
        -- Conform can also run multiple formatters sequentially
        go = { 'goimports', 'goimports-reviser', 'golines', 'gofmt' },
        html = { { 'prettierd', 'prettier' } },
        javascript = { { 'prettierd', 'prettier' } },
        javascriptreact = { { 'prettierd', 'prettier' } },
        json = { { 'prettierd', 'prettier' } },
        lua = { 'stylua' },
        markdown = { 'markdownlint' },
        python = { 'isort', 'black' },
        sh = { 'shfmt' },
        svelte = { { 'prettierd', 'prettier' } },
        templ = { 'templ' },
        typescript = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
        yaml = { 'yamlfmt' },
        zig = { 'zigfmt' },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
