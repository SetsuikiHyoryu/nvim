# Neovim Configuration Directory

## 0.10 重大更新

- [What's New in Neovim 0.10](https://gpanders.com/blog/whats-new-in-neovim-0.10/)
- [News-0.10](https://neovim.io/doc/user/news-0.10.html)

## 打印信息

```lua
-- 将会显示在 Neovim 的控制台中。
-- `:message` 可以再次查看到。
print('white thighhighs')
```

## Neovim Lua 接口

- `vim.inspect`: 返回 table 内容。
- `vim.fn`: 原生 vim 函数的桥接器。

## 启动速度优化

`:Lazy` -> `P` 检查启动速度，找出速度慢的插件后将其改为 `event = 'VeryLazy'`。

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
