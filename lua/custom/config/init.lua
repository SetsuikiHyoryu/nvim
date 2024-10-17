-- 主题的配置必须最优先，否则会覆盖之后的颜色组设置。
require 'custom.config.onedark'

-- 这两个顺序颠倒会造成 bufferline 背景透明
require 'custom.config.bufferline'
require 'custom.config.highlight'

require 'custom.config.treesitter'
require 'custom.config.tab'
require 'custom.config.lsp'
require 'custom.config.nvim-cmp'
require 'custom.config.markdown'
