return {
  -- Autoformat
  'stevearc/conform.nvim',
  lazy = false,
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,

    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      -- local disable_filetypes = {
      --   -- c = true,
      --   -- cpp = true,
      -- }
      -- return {
      --   timeout_ms = 500,
      --   lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      -- }
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

      -- Conform can also run multiple formatters sequentially
      python = { 'isort', 'black' },

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
    },

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function(args)
        require('conform').format { bufnr = args.buf }
      end,
    }),
  },
}
