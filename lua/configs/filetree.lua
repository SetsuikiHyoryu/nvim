vim.pack.add { 'https://github.com/stevearc/oil.nvim' }

require('oil').setup {
  keymaps = {
    ['<C-p>'] = { 'actions.preview', opts = { vertical = true, split = 'botright' } },
  },
}
