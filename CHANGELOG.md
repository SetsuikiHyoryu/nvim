# Changelog

## [Latest]

## [0.2.1] （personal）

### Fixed (0.2.1)

- Fix Volar not working with mason-lspconfig 2.0+ due to native LSP function usage.

## [0.2.0]

### Changed (0.2.0)

- Replace `vim.highlight` with `vim.hl`.
  - Reason: <https://github.com/nvim-lua/kickstart.nvim/pull/1482>.
- Allow neo-tree to hijack netrw on startup
  - Reason: <https://github.com/nvim-lua/kickstart.nvim/pull/1489>
- Replace `vim.opt` with `vim.o`.
  - Reason: <https://github.com/nvim-lua/kickstart.nvim/pull/1495>
- Change Mason to new address.
- Switch vim-sleuth for guess-indent.nvim.

### Deprecated (0.2.0)

- Change `lua\custom\config\tab.lua` to `lua\custom\config\indent$deprecated.lua`.

## [0.1.0]

[Latest]: https://github.com/nvim-lua/kickstart.nvim/compare/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6...master
[0.2.1]: https://github.com/nvim-lua/kickstart.nvim/compare/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6...master
[0.2.0]: https://github.com/nvim-lua/kickstart.nvim/compare/d350db2449da40df003c40d440f909d74e2d4e70...6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6
[0.1.0]: https://github.com/nvim-lua/kickstart.nvim/commit/d350db2449da40df003c40d440f909d74e2d4e70
