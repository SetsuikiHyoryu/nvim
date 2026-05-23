vim.pack.add {
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-rhubarb',
}

vim.pack.add { 'https://github.com/lewis6991/gitsigns.nvim' }

local gitsigns = require 'gitsigns'

gitsigns.setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

local map = vim.keymap.set

-- 导航
map('n', ']c', function()
  if vim.wo.diff then
    return ']c'
  end
  vim.schedule(function()
    gitsigns.nav_hunk 'next'
  end)
  return '<Ignore>'
end, { expr = true, desc = 'Next git hunk' })

map('n', '[c', function()
  if vim.wo.diff then
    return '[c'
  end
  vim.schedule(function()
    gitsigns.nav_hunk 'prev'
  end)
  return '<Ignore>'
end, { expr = true, desc = 'Previous git hunk' })

-- 操作
map('v', '<leader>hs', function()
  gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, { desc = 'git [s]tage selection' })
map('v', '<leader>hr', function()
  gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
end, { desc = 'git [r]eset selection' })
map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'git preview hunk [i]nline' })
map('n', '<leader>hb', function()
  gitsigns.blame_line { full = true }
end, { desc = 'git [b]lame line' })
map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
map('n', '<leader>hD', function()
  gitsigns.diffthis '@'
end, { desc = 'git [D]iff against last commit' })
map('n', '<leader>hq', gitsigns.setqflist, { desc = 'git quickfix for current buffer' })
map('n', '<leader>hQ', function()
  gitsigns.setqflist 'all'
end, { desc = 'git quickfix for all buffers' })

-- 开关
map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = '[T]oggle git [w]ord diff' })

-- 文本对象
map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'Select git hunk' })
