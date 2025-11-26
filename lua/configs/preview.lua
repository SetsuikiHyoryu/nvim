local preview_group = vim.api.nvim_create_augroup('Preview', { clear = true })

vim.pack.add { 'https://github.com/MeanderingProgrammer/render-markdown.nvim' }

-- 取消代码块背景色（放在 `autocmd` 内会有一部分不生效）。
-- 虽然 `render-markdown` 提供了取消代码块正文背景色的功能，
-- 但是语言栏和边框没有提供。
vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { link = 'none', bg = 'none' })

vim.api.nvim_create_autocmd('FileType', {
  group = preview_group,
  once = true,
  pattern = 'markdown',
  callback = function()
    require('render-markdown').setup {
      heading = {
        sign = false,
        backgrounds = {},
      },

      code = {
        sign = false,
        width = 'block',
        disable_background = true,
      },

      overrides = {
        buftype = {
          nofile = {
            code = { language = false },
          },
        },
      },
    }
  end,
})

vim.pack.add { 'https://github.com/chomosuke/typst-preview.nvim' }

vim.api.nvim_create_autocmd('FileType', {
  group = preview_group,
  once = true,
  pattern = 'typ',
  callback = function()
    require('typst-preview').setup {
      -- dark mode
      --
      -- 不让图片反色的配置
      -- `'{"rest": "always", "image": "never"}'`
      -- 由于 JSON 转译等原因，不能正常传输给 `tinymist`。
      invert_colors = 'always',
    }
  end,
})
