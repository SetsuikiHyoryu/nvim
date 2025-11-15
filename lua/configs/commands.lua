-- 创建切换光标行是否显示的命令。
vim.api.nvim_create_user_command('ToggleCursorline', function()
  vim.opt.cursorline = not vim.opt.cursorline:get()
end, {})

-- 打印运行时路径（用来查看插件）。
vim.api.nvim_create_user_command('ListRuntimePaths', function()
  for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
    print(path)
  end
end, {})
