-- `tabline` 会在任何时候显示所有打开的 buffer。
-- 这个插件用来在不同的 tab 中显示不同的 buffer。
vim.pack.add { 'https://github.com/tiagovla/scope.nvim' }
require('scope').setup()

-- `tabline` 会和 `vim.pack.add` 的窗口冲突，
-- 不可以在 `tabline` 之后安装其他插件。
vim.pack.add { 'https://github.com/nvim-mini/mini.tabline' }
require('mini.tabline').setup()
