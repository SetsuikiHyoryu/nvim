vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

require('conform').setup {
  notify_on_error = false,

  -- 开发者说是推荐。
  format_on_save = {
    lsp_format = 'fallback',
    timeout_ms = 500,
  },

  -- See: https://github.com/stevearc/conform.nvim?tab=readme-ov-file#customizing-formatters
  -- See: :help conform-options
  formatters = {
    prettier = {
      prepend_args = { '--no-semi', '--single-quote' },
    },
  },

  formatters_by_ft = {
    lua = { 'stylua' },
    markdown = { 'prettier' },
    javascript = { 'prettier' },
    javascriptreact = { 'prettier' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    vue = { 'prettier' },
    html = { 'prettier' },
    css = { 'prettier' },
    json = { 'prettier' },
    yaml = { 'prettier' },
    go = { 'goimports', 'gofmt' },
    rust = { 'rustfmt' },
    c = { 'clang-format' },
    python = { 'black' },
  },
}

-- 似乎是插入模式下格式不符合预期时自动格式化。
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
