require 'custom.config.lsp'
require 'custom.config.nvim-cmp'
require 'custom.config.tab'
require 'custom.config.treesitter'
require 'custom.config.markdown'
-- require 'custom.config.vscode'
require 'custom.config.onedark'
require 'custom.config.bufferline'
require 'custom.config.highlight'

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Make line numbers default
vim.o.number = true

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Enable break indent
vim.o.breakindent = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
-- 0.10+ 自动检测是否可用真彩色，可用则启动。此处为了兼容低版本，我仍旧保留了手动启用。
-- see: https://gpanders.com/blog/whats-new-in-neovim-0.10/#hyperlinks
vim.o.termguicolors = true

-- Powershell 中 Ctrl + Z 程序会失去响应，替换为返回键
vim.keymap.set('n', '<C-Z>', 'u', { silent = true })
-- 启用光标行
vim.o.cursorline = true
-- 隐藏命令行（在输入命令时会临时覆盖状态栏）
-- vim.o.cmdheight = 0

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
