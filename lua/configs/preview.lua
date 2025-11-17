local preview_group = vim.api.nvim_create_augroup('Preview', { clear = true })

vim.pack.add { 'https://github.com/OXY2DEV/markview.nvim' }

vim.api.nvim_create_autocmd('FileType', {
  group = preview_group,
  once = true,
  pattern = 'markdown',
  callback = function()
    require('markview').setup {
      ---@diagnostic disable-next-line: missing-fields
      markdown = {
        ---@diagnostic disable-next-line: missing-fields
        code_blocks = {
          sign = false,
          style = 'simple',
          label_direction = 'left',
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
