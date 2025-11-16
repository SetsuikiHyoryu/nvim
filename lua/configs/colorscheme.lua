vim.pack.add { 'https://github.com/folke/tokyonight.nvim' }

require('tokyonight').setup {
  transparent = true,
  styles = {
    comments = { italic = false },
    sidebars = 'transparent',
    floats = 'transparent',
  },

  -- 我不用到的配置，但不加会提示缺少 `field`。
  on_highlights = function() end,
  on_colors = function() end,
}

vim.cmd.colorscheme 'tokyonight-night'

-- [[ Highlight on yank ]]
-- See `:help vim.hl.on_yank()`
-- Yank 时高亮一下以提醒。
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('YankHighlight', { clear = true }),
  pattern = '*',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[修改高亮组自定义函数]]
--- 合并两个表格。
--- @param target table 合并至的目标表格
--- @param another table 被合并的表格
--- @return table 合并后的表格。
local function merge_table(target, another)
  for key, value in pairs(another) do
    target[key] = value
  end

  return target
end

--- 继承高亮配置。
--- @param orignal table 原高亮配置。
--- @param new_maps table 需要更新的高亮配置。
--- @return table 继承原配置的更新后的高亮配置。
local function inherit_hl(orignal, new_maps)
  local inherited = merge_table({}, orignal)
  inherited = merge_table(inherited, new_maps)

  return inherited
end

--- 设置自定义高亮。
--- @param groups table 高亮组列表。
--- @param new_maps table 需要更新的高亮配置。
local function set_custom_hl(groups, new_maps)
  for _, group in ipairs(groups) do
    local hl = vim.api.nvim_get_hl(0, { name = group })
    vim.api.nvim_set_hl(0, group, inherit_hl(hl, new_maps))
  end
end

-- [[清除背景颜色]]
local no_bg = { bg = 'none', ctermbg = 'none' }

local hl_groups = {
  'CursorLine', -- 光标行
  'Normal', -- 正文背景
  'DiffviewNormal', -- diff 正文背景
  'EndOfBuffer', -- buffer 最后一行之外的区域，即填充屏幕的部分。
  'SignColumn', -- 标志列（行号列左侧）
  'FoldColumn', -- 折叠列（标示列左侧）
  'StatusLine', -- 状态栏
  -- 'NonText', -- 无字区，目前已经是无背景，但是不知道哪个插件设置的。

  -- Treesitter Language: Markdown
  '@markup.raw.markdown_inline', -- inline code block
  '@markup.heading.1.markdown', -- heading (仅在 MacOS 中遭遇背景)
  '@markup.heading.2.markdown', -- heading (仅在 MacOS 中遭遇背景)
  '@markup.heading.3.markdown', -- heading (仅在 MacOS 中遭遇背景)
  '@markup.heading.4.markdown', -- heading (仅在 MacOS 中遭遇背景)
  '@markup.heading.5.markdown', -- heading (仅在 MacOS 中遭遇背景)
  '@markup.heading.6.markdown', -- heading (仅在 MacOS 中遭遇背景)
  '@markup.heading.7.markdown', -- heading (仅在 MacOS 中遭遇背景)
  '@markup.heading.8.markdown', -- heading (仅在 MacOS 中遭遇背景)
}

set_custom_hl(hl_groups, no_bg)

-- Markview
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('MarkviewHighlightCustom', { clear = true }),
  pattern = 'markdown',
  once = true,
  callback = function()
    local markview_hl_groups = {
      'MarkviewCode',
      'MarkviewInlineCode',
      'MarkviewPalette1',
      'MarkviewPalette2',
      'MarkviewPalette3',
      'MarkviewPalette4',
      'MarkviewPalette5',
      'MarkviewPalette6',
      'MarkviewPalette1Sign',
      'MarkviewPalette2Sign',
      'MarkviewPalette3Sign',
      'MarkviewPalette4Sign',
      'MarkviewPalette5Sign',
      'MarkviewPalette6Sign',
    }

    set_custom_hl(markview_hl_groups, no_bg)
  end,
})

-- 行内信息（`gui=bold` 似于是默认值）
local diagnostic_texts = { 'DiagnosticVirtualTextHint', 'DiagnosticVirtualTextError', 'DiagnosticVirtualTextInfo', 'DiagnosticVirtualTextWarn' }
local diagnostic_texts_configs = merge_table(no_bg, { bold = true })
set_custom_hl(diagnostic_texts, diagnostic_texts_configs)

-- [[光标行]]
-- 链接其他光标行颜色组
set_custom_hl({
  'CursorLineNr', -- 光标行（数字）
  -- 标志的光标行和 gitsigns 的颜色组不为同一个，所以不设置了。
  -- 'CursorLineSign', -- 光标行（标志）
}, { link = 'CursorLine' })

-- 创建切换光标行是否显示的命令。
vim.api.nvim_create_user_command('CursorLine', function()
  local bg = vim.api.nvim_get_hl(0, { name = 'CursorLine' }).bg
  local new_bg = bg and 'none' or '#31353f'
  set_custom_hl({ 'CursorLine' }, { bg = new_bg })
end, {})

-- [[gui 透明度，默认值为 0，数字越大越透明]]
-- vim.o.winblend = 10 -- floating window
-- vim.o.pumblend = 10 -- popup-menu
