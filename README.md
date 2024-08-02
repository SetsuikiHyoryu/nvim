# README

这是 Neovim 的自定义设置。

## 备忘录

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
