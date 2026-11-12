vim.pack.add { 'https://github.com/stevearc/conform.nvim' }

require('conform').setup {
  notify_on_error = false,

  default_format_opts = {
    lsp_format = 'fallback',
  },

  format_on_save = function()
    if vim.g.disable_autoformat then
      return
    end

    return {
      timeout_ms = 500,
    }
  end,

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
    jsonc = { 'prettier' },
    yaml = { 'prettier' },
    go = { 'goimports', 'gofmt' },
    rust = { 'rustfmt' },
    c = { 'clang-format' },

    -- See: <https://docs.astral.sh/ruff/editors/setup/#neovim>
    -- find `conform`
    python = { 'ruff_fix', 'ruff_organize_imports', 'ruff_format' },
  },
}

-- 似乎是插入模式下格式不符合预期时自动格式化。
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.api.nvim_create_user_command('FormatToggle', function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  if vim.g.disable_autoformat then
    print 'format_on_save: OFF'
  else
    print 'format_on_save: ON'
  end
end, {})
