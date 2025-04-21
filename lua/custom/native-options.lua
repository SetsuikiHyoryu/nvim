-- Neovim 原生即有的配置项。

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- NOTE: You should make sure your terminal supports this
-- 0.10+ 自动检测是否可用真彩色，可用则启动。此处为了兼容低版本，我仍旧保留了手动启用。
-- see: https://gpanders.com/blog/whats-new-in-neovim-0.10/#hyperlinks
vim.opt.termguicolors = true

-- Make line numbers default
vim.opt.number = true
-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'
-- 禁用鼠标
vim.opt.mouse = ''
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
-- Enable break indent
vim.opt.breakindent = true
-- 隐藏命令行（在输入命令时会临时覆盖状态栏）
-- vim.opt.cmdheight = 0

-- 创建切换光标行是否显示的命令
vim.api.nvim_create_user_command('ToggleCursorline', function()
  vim.opt.cursorline = not vim.opt.cursorline:get()
end, {})

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Powershell 中 Ctrl + Z 程序会失去响应，替换为返回键
vim.keymap.set('n', '<C-Z>', 'u', { silent = true })

-- 强化 Markdown 中链接的渲染输出
-- see: https://gpanders.com/blog/whats-new-in-neovim-0.10/#hyperlinks
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = { 'markdown' },
--   once = true,
--
--   callback = function()
--     vim.opt.conceallevel = 2
--   end,
-- })

-- [[ Diagnostic keymaps ]]
-- 0.10+ 中已经内置 `[d`, `]d` 映射
-- see: https://neovim.io/doc/user/news-0.10.html
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true
