return {
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '0.3.*',

    opts = {
      -- dark mode
      invert_colors = 'always',
    },

    build = function()
      require('typst-preview').update()
    end,
  },
}
