-- 打印运行时路径（用来查看插件）。
vim.api.nvim_create_user_command('ListRuntimePaths', function()
  for _, path in ipairs(vim.api.nvim_list_runtime_paths()) do
    print(path)
  end
end, {})
