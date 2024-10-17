return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      { '\\', ':Neotree toggle reveal<CR>', desc = 'NeoTree toggle reveal', silent = true },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
    },
    config = function()
      -- 让缩进竖线和 IndentBlank 保持一致
      vim.api.nvim_set_hl(0, 'NeoTreeIndentMarker', { link = 'IndentBlanklineChar' })

      -- 在离开 Tab 时自动关闭文件树边栏
      vim.api.nvim_create_autocmd('TabLeave', {
        callback = function()
          vim.cmd 'Neotree close'
        end,
      })
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
