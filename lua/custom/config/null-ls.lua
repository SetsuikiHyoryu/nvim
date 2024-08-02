local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettierd.with({
      extra_args = {
        "--single-quote",
        "--no-semi",
        "--print-width 80",
      },
    }),

    null_ls.builtins.diagnostics.markdownlint
  },
})
