-- 启用 Neovim 内置的 Lua 字节码缓存。
-- 原理：首次 require 时，将 Lua 源码编译为字节码并缓存到磁盘，
-- 后续启动直接加载字节码，跳过 CommonMark 解析和编译步骤。
-- 关键：必须放在所有 require 之前，否则在此之前被加载的模块不会被缓存。
vim.loader.enable()

require 'configs'
