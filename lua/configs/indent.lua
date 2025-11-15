vim.pack.add { 'https://github.com/lukas-reineke/indent-blankline.nvim' }

require('ibl').setup {
  indent = {
    char = '│',
  },

  -- 光标在嵌套块中时提示，先试用一阵子。
  -- scope = {
  --   enabled = false,
  -- },
}

vim.pack.add { 'https://github.com/NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}

-- 使用 `NMAC427/guess-indent.nvim` 时仍需要保留这个文件以设置缩进。
-- 因为它无法在新建文件中做出推断。

-- 修改 indent 的宽度
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

local indent_group = vim.api.nvim_create_augroup('IndentGroup', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = indent_group,
  pattern = { 'go' },
  callback = function()
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = indent_group,
  pattern = { 'cs', 'java' },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})
