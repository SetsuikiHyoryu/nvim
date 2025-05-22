-- 使用 `NMAC427/guess-indent.nvim` 时仍需要保留这个文件以设置缩进。
-- 因为它无法在新建文件中做出推断。

-- 修改 indent 的宽度
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go' },

  callback = function()
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'cs', 'java' },

  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown' },

  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})
