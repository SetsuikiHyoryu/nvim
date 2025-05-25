# README

这是 Neovim 的自定义设置。

## 备忘录

### 启动速度优化

`:Lazy` -> `P` 检查启动速度，找出速度慢的插件后将其改为 `event = 'VeryLazy'`。

### 0.10 重大更新

- [What's New in Neovim 0.10](https://gpanders.com/blog/whats-new-in-neovim-0.10/)
- [News-0.10](https://neovim.io/doc/user/news-0.10.html)

### 打印信息

```lua
# 将会显示在 Neovim 的控制台中
print('white thighhighs')
```

### 查看 Mason 中的依赖的安装地址

```lua
# obj:method() == obj.method(obj)
local path = require('mason-registry').get_package('vue-language-server'):get_install_path()
```

### 拼接字符串

```lua
'white ' .. 'thighhighs'
```

### Neovim Lua 接口

- `vim.inspect`: 返回 table 内容。

### 命令模式快捷键

- `CTRL-R`: 打开寄存器列表。
- `CTRL-F`: 同 `:q`。

### 其他快捷键相关

- `:verbose map`: 查看当前 buffer 中生效的键映射。
- `[、]`: 许多跳转的快捷键的前置。
  - `[b、]b、[B、]B`：跳转 buffer。
  - `[<space>、]<space>`: 普通模式下上下插入空行。
