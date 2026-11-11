-- Java LSP.
-- 让 `nvim-jdtls` 比 `nvim-lspconfig` 先加载可以做到只启用 `nvim-jdtls` 的配置。
-- 不知道是 `lsp/` 发生了顶替还是 `jdtls` 只允许一个实例还是 Neovim 去重了实例。
-- `after/lsp/` 里如果写配置，可以正常合并与覆盖。
vim.pack.add { 'https://github.com/mfussenegger/nvim-jdtls' }
