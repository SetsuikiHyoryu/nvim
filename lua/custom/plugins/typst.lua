return {
  {
    'chomosuke/typst-preview.nvim',
    ft = 'typst',
    version = '1.*',

    opts = {
      -- dark mode
      --
      -- 不让图片反色的配置
      -- `'{"rest": "always", "image": "never"}'`
      -- 由于 JSON 转译等原因，不能正常传输给 `tinymist`。
      invert_colors = 'always',
    },
  },
}
