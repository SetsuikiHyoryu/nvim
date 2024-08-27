-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
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
  'Normal', -- 正文背景
  'DiffviewNormal', -- diff 正文背景
  'EndOfBuffer', -- buffer 最后一行之外的区域，即填充屏幕的部分。
  'SignColumn', -- 标志列（行号列左侧）
  'FoldColumn', -- 折叠列（标示列左侧）
  'StatusLine', -- 状态栏
  -- 'NonText', -- 无字区，目前已经是无背景，但是不知道哪个插件设置的。

  -- nvim-tree
  'NvimTreeNormal', -- 背景（有字区）
  'NvimTreeEndOfBuffer', -- 背景（无字区）
}

set_custom_hl(hl_groups, no_bg)

-- 行内信息（`gui=bold` 似于是默认值）
local diagnostic_texts = { 'DiagnosticVirtualTextHint', 'DiagnosticVirtualTextError', 'DiagnosticVirtualTextInfo', 'DiagnosticVirtualTextWarn' }
local diagnostic_texts_configs = merge_table(no_bg, { bold = true })
set_custom_hl(diagnostic_texts, diagnostic_texts_configs)

-- 光标行背景色
local cursorline_color_bg = { bg = '#31353f' }

-- 关闭光标行背景色
-- 虽然 `vim.opt.cursorline` 可以控制光标所在行有无背景色，但是有些插件会默认开启，所以不想显示光标行就需要更改光标行背景色。
vim.api.nvim_set_hl(0, 'CursorLine', no_bg) -- 光标行（无背景色）

-- 点亮光标行背景色
-- set_custom_hl({
--   'CursorLine', -- 光标行
--   'CursorLineNr', -- 光标行（数字）
-- }, cursorline_color_bg)

-- 创建切换光标行是否显示的命令
vim.api.nvim_create_user_command('ToggleCursorline', function()
  local hl_cursorline = vim.api.nvim_get_hl(0, { name = 'CursorLine' })

  local bg_is_nil = vim.tbl_isempty(hl_cursorline) or hl_cursorline.bg == nil
  set_custom_hl({
    'CursorLine', -- 光标行
    'CursorLineNr', -- 光标行（数字）
  }, bg_is_nil and cursorline_color_bg or no_bg)
end, {})

-- [[gui 透明度，默认值为 0，数字越大越透明]]
-- vim.opt.winblend = 10 -- floating window
-- vim.opt.pumblend = 10 -- popup-menu
