-- 修改 tab 显示的宽度
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },

  callback = function()
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cs", "java" },

  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
  end
})
