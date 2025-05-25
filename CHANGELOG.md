# Changelog

## [Unreleased]

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

[Unreleased]: https://github.com/nvim-lua/kickstart.nvim/compare/3338d3920620861f8313a2745fd5d2be39f39534...master
[0.6.1]: https://github.com/nvim-lua/kickstart.nvim/compare/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6...3338d3920620861f8313a2745fd5d2be39f39534
[0.6.0]: https://github.com/nvim-lua/kickstart.nvim/compare/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6...3338d3920620861f8313a2745fd5d2be39f39534
[0.5.1]: https://github.com/nvim-lua/kickstart.nvim/compare/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6...3338d3920620861f8313a2745fd5d2be39f39534
[0.5.0]: https://github.com/nvim-lua/kickstart.nvim/compare/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6...3338d3920620861f8313a2745fd5d2be39f39534
[0.4.0]: https://github.com/nvim-lua/kickstart.nvim/compare/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6...3338d3920620861f8313a2745fd5d2be39f39534
[0.3.0]: https://github.com/nvim-lua/kickstart.nvim/compare/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6...3338d3920620861f8313a2745fd5d2be39f39534
[0.2.2]: https://github.com/nvim-lua/kickstart.nvim/compare/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6...3338d3920620861f8313a2745fd5d2be39f39534
[0.2.1]: https://github.com/nvim-lua/kickstart.nvim/compare/6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6...3338d3920620861f8313a2745fd5d2be39f39534
[0.2.0]: https://github.com/nvim-lua/kickstart.nvim/compare/d350db2449da40df003c40d440f909d74e2d4e70...6ba2408cdf5eb7a0e4b62c7d6fab63b64dd720f6
[0.1.0]: https://github.com/nvim-lua/kickstart.nvim/commit/d350db2449da40df003c40d440f909d74e2d4e70
