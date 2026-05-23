# AGENTS.md

## 项目概览

个人 Neovim 配置，使用 Neovim 0.12+ 内置的 `vim.pack` 管理插件。

## 架构

- `init.lua` → `require 'configs'` → `lua/configs/init.lua` 按顺序加载 16 个模块
- 每个模块在 `lua/configs/<name>.lua` 中，一个模块 = 一个关注点（lsp, completion, git 等）
- `lua/utils.lua` — 共享工具函数
- `after/lsp/` — 按语言覆盖 LSP 配置（jdtls, rust_analyzer, ts_ls）
- `kickstart.nvim/` — 参考用的上游副本（已 git-ignored，不参与配置）
- `lua/configs/deprecated-debug.lua` — 旧 lazy.nvim 风格代码，未被 `require`，仅作参考

## 关键规则

### 加载顺序不可变
`lua/configs/init.lua` 中的 `require` 顺序是刻意安排的：
- **`tabline` 必须放在最后**。`vim.pack.add` 窗口会和 `mini.tabline` 产生显示冲突。
- `colorscheme` 必须在 `vim.cmd.colorscheme` 之前完成 `vim.pack.add`。

### 插件安装范式
```lua
vim.pack.add { 'https://github.com/author/plugin' }
-- 或带版本约束：
vim.pack.add { { src = 'https://github.com/author/plugin', version = vim.version.range '1.*' } }
require('plugin').setup { ... }
```
插件的 `vim.pack.add` 和 `.setup()` 写在同一文件中。

### 懒加载模式
blink.cmp 和 nvim-autopairs 通过 `once = true` 的 `InsertEnter`/`CmdlineEnter` autocmd 延迟初始化，避免启动时加载。

### LSP 自定义
- 语言服务器列表在 `lua/configs/lsp.lua:31-43`（`vim.lsp.enable` 循环）
- 按语言覆盖配置写入 `after/lsp/<server>.lua`，返回一个 table（Neovim 会自动合并到默认配置）
- `jdtls` 需要环境变量 `JAVA_HOME_FOR_JDTLS`、`JAVA_HOME_17`、`JAVA_HOME_21`
- `vue_ls` 需要 Mason 中安装 `vue-language-server`

### Treesitter
Treesitter 高亮和缩进**不会自动启用**。`treesitter.lua` 中的 `FileType` autocmd 负责调用 `vim.treesitter.start()` 并设置 `indentexpr`。添加新语言时，确保 parser 已安装或列在 `available_parsers` 中。

## 格式化

- **stylua**：列宽 160，2 空格缩进，单引号，无调用括号（`require 'foo'` 而非 `require('foo')`）
- **formatter 映射**：`conform.nvim` 在 `autoformat.lua` 中按文件类型配置

## 环境

- **Neovim >= 0.12**（使用 `vim.pack`、`vim.lsp.enable`、`snacks.nvim` 等）
- **Mason** 管理 LSP 服务器和外部工具
- `nvim-pack-lock.json` 已被 git-ignored
