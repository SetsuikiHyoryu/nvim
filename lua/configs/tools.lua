vim.pack.add { 'https://github.com/nvim-lua/plenary.nvim' }

vim.pack.add { 'https://github.com/folke/which-key.nvim' }
require('which-key').setup {
  delay = 0,
  spec = {
    { '<leader>s', group = '[S]earch' },
    { '<leader>t', group = '[T]oggle' },
  },
}

vim.pack.add { 'https://github.com/windwp/nvim-autopairs' }

vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
  group = vim.api.nvim_create_augroup('Autopairs', { clear = true }),
  once = true,
  callback = function()
    require('nvim-autopairs').setup()
  end,
})
