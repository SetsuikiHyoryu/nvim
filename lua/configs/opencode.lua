vim.pack.add { 'https://github.com/nickjvandyke/opencode.nvim' }
local opencode = require 'opencode'

vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
  opencode.ask()
end, { desc = '[O]penCode [A]sk' })
vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
  opencode.select()
end, { desc = '[O]penCode [S]elect' })
vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
  opencode.toggle()
end, { desc = '[O]penCode [T]oggle' })

vim.keymap.set({ 'n', 'x' }, 'go', function()
  return opencode.operator '@this '
end, { desc = 'OpenCode: Add range to OpenCode', expr = true })
vim.keymap.set('n', 'goo', function()
  return opencode.operator '@this ' .. '_'
end, { desc = 'OpenCode: Add line to OpenCode', expr = true })

vim.g.opencode_opts = {
  server = {
    -- 禁止在找不到 OpenCode 实例时嵌入式打开终端。
    start = false,
  },
}
