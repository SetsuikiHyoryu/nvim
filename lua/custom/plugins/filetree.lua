return {
  -- [[deprecated]]
  -- {
  --   'nvim-neo-tree/neo-tree.nvim',
  --   version = '*',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
  --     'MunifTanjim/nui.nvim',
  --   },
  --   lazy = false,
  --   keys = {
  --     { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  --   },
  --   opts = {
  --     filesystem = {
  --       window = {
  --         mappings = {
  --           ['\\'] = 'close_window',
  --         },
  --       },
  --     },
  --   },
  --   init = function()
  --     -- 在离开 Tab 时自动关闭文件树边栏
  --     vim.api.nvim_create_autocmd('TabLeave', {
  --       callback = function()
  --         vim.cmd 'Neotree close'
  --       end,
  --     })
  --   end,
  -- },

  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      keymaps = {
        ['<C-p>'] = { 'actions.preview', opts = { vertical = true, split = 'botright' } },
      },
    },
    -- Optional dependencies
    dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
  },
}
