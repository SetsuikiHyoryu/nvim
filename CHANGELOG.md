# Changelog

## [Unreleased]

### Added

- Add `custom.utils` module and `isWindows` util function.

### Changed

- Adjust `echasnovski/mini.nvim` to `nvim-mini/mini.nvim`.
- Move `ts_ls` LSP configuration out of deprecated.

### Deprecated

- Deprecate unnecessary diagnostic configuration.
- Deprecate the `vtsls` LSP server.

### Removed

- Remove unused `null-ls` plugin configuration file.
- Remove deprecated `capabilities` configuration.
- Remove deprecated `neo-tree` plugin.

## [1.0.0] - 2025-07-23

### Added (1.0.0)

- Add `vtsls` config to support Vue LSP v3.0.0 (relased on 2025-07-02).

### Deprecated (1.0.0)

- Deprecate `capabilities` because it is already called automatically  
  within `blink.cmp`.
- Deprecate the `ts_ls` custom LSP config due to a breaking change  
  introduced in the Vue LSP update in v3.0.0.

### Removed (1.0.0)

- Remove the `mason-lspconfig` old config for versions < v2.0.0.

## [0.6.1] - 2025-05-26

### Added (0.6.1)

- Add lua note for display table with `vim.inspect`.

### Changed (0.6.1)

- Update cmd arguments for `markdownlint`.

## [0.6.0] - 2025-05-23

### Added (0.6.0)

- Add `nvim-surround`.
- Add `typescript-tools` but keep it disabled.
- Add Markdown filetype's indent config.
- Add startup arguments for `markdownlint`.

### Changed (0.6.0)

- Canel indent config file deprecation.
- Enable `nmac427/guess-indent.nvim`.

## [0.5.1] - 2025-05-19

### Removed (0.5.1)

- Remove mini.surround because it makes `s` delay.

## [0.5.0] - 2025-05-19

### Added (0.5.0)

- mini.ai.
- mini.surround.

### Changed (0.5.0)

- Replace onedark.nvim with tokyonight.nvim.
- Replace lualine and bufferline with mini.nvim.
- Make markdown conceallevel 2 active.

### Removed (0.5.0)

- Delete `<leader>e` keymap, `CTRL-W_d` is built-in.

## [0.4.0]

### Changed (0.4.0)

- Update oil.nvim config.

### Deprecated (0.4.0)

- Comment out neo-tree.nvim.

### Fixed (0.4.0)

- Update indent-blankline.nvim comment.

## [0.3.0]

### Changed (0.3.0)

- Make the debug feature effective.

## [0.2.2]

### Fixed (0.2.2)

- Fixed the issue where the `opts` for neo-tree were bugged when used together  
  with `config`.

## [0.2.1]

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

[Unreleased]: https://github.com/SetsuikiHyoryu/nvim-windows/compare/v1.0.0...main
[1.0.0]: https://github.com/SetsuikiHyoryu/nvim-windows/releases/tag/v1.0.0
