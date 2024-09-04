return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',

    config = function()
      require('nvim-tree').setup {}

      -- disable netrw at the very start of your init.lua
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- set termguicolors to enable highlight groups
      vim.opt.termguicolors = true

      -- 在离开 Tab 时自动关闭文件树边栏
      local api = require 'nvim-tree.api'
      vim.api.nvim_create_autocmd('TabLeave', {
        callback = function()
          api.tree.close_in_this_tab()
        end,
      })

      vim.keymap.set('n', '<leader>t', ':NvimTreeFindFileToggle<CR>', { silent = true })
    end,
  },

  {
    'stevearc/oil.nvim',
    -- Optional dependencies
    -- dependencies = { 'echasnovski/mini.icons' },
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons

    config = function()
      require('oil').setup {
        view_options = {
          show_hideen = true,
        },
      }

      -- Open parent directory in current window.
      vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    end,
  },
}
