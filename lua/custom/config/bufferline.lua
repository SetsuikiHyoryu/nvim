vim.o.termguicolors = true
local bufferline = require 'bufferline'

bufferline.setup {
  options = {
    mode = 'tabs',
    style_preset = bufferline.style_preset.no_italic,
  },

  highlights = {
    fill = {
      bg = {
        attribute = 'bg',
        highlight = 'StatusLine',
      },
    },
  },
}
