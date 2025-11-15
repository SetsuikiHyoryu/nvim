vim.pack.add { 'https://github.com/folke/snacks.nvim' }
local snacks = require 'snacks'
snacks.setup()

local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = 'LSP: ' .. desc })
end

map('<leader>sf', snacks.picker.files, '[S]earch [F]iles')
map('<leader>sg', snacks.picker.grep, '[S]earch by [G]rep')
map('<leader>sh', snacks.picker.help, '[S]earch [H]elp')
map('<leader>sk', snacks.picker.keymaps, '[S]earch [K]eymaps')
map('<leader>sl', snacks.picker.highlights, '[S]earch high[L]ights')
map('<leader>ss', snacks.picker.smart, '[S]earch [S]mart')
map('<leader>sw', snacks.picker.grep_word, '[S]earch currenet [W]ord')
map('<leader>s.', snacks.picker.recent, '[S]earch Recent Files ("." for repeat)')
