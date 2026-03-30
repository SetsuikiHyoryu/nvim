# Neovim Configuration Directory

## 参考资料

- 用户文档：<https://neovim.io/doc/user/>
- LSP 全局默认按键：<https://neovim.io/doc/user/lsp.html#_defaults>

## 打印信息

```lua
-- 将会显示在 Neovim 的控制台中。
-- `:message` 可以再次查看到。
print('white thighhighs')
```

- `:Inspect`: 打印当前光标处的语法信息（查高亮组极有用）。
- `:autocmd [event]`： 打印事件。
- `:verbose <command>`: 输出指定命令的调试信息。
- `:scriptnames`: 查看所有已加载脚本（查看哪些插件启用了）。

## Neovim Lua 接口

- `vim.inspect`: 返回 table 内容。
- `vim.fn`: 原生 vim 函数的桥接器。
- `:packadd nvim.xxx`: 在当前会话激活一些实用命令。
  - `:TOHtml` (`nvim.tohtml`): 将当前 buffer 的渲染结果保存为静态 HTML。

## 0.11 以来的官方内置化的原插件提供的功能

- `vim.pack`: 插件管理器。
  - `vim.pack.update` 不会改变分支，需要手动管理插件的重大更新。
- `vim.lsp`: 原 `nvim-lspconfig`。
- `vim.treesitter`: 原 `nvim-treesitter`。

这些被官方内置化了的原插件本身，目前基本都成为了下载更多解释器和服务的下载器。

## 查看 Mason 中的依赖的安装地址

```lua
local vue_lsp_location = vim.fn.expand '$MASON/packages'
  .. '/vue-language-server'
  .. '/node_modules/@vue/language-server'
```

## 拼接字符串

```lua
'white ' .. 'thighhighs'
```

## 快捷键

### 命令模式快捷键

- `CTRL-R`: 打开寄存器列表。
- `CTRL-F`: 同 `:q`。

### 其他快捷键相关

- `:verbose map`: 查看当前 buffer 中生效的键映射。
- `[、]`: 许多跳转的快捷键的前置（**`help motion.txt`**）。
  - `[b、]b、[B、]B`：跳转 buffer。
  - `[<space>、]<space>`: 普通模式下上下插入空行。
  - `[[`...: Session.
  - `[(/{/<`: `(/{/<`.
  - `[m`: method.
