vim.pack.add {
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
  },
}

local plugin_treesitter = require 'nvim-treesitter'

local parsers = { 'bash', 'diff', 'gitcommit', 'git_rebase', 'luadoc' }
plugin_treesitter.install(parsers)

---@param buf integer
---@param language string
local function treesitter_try_attach(buf, language)
  if not vim.treesitter.language.add(language) then
    return
  end

  vim.treesitter.start(buf, language)

  -- 这是 treesitter 控制的折叠，注释以默认不开。
  -- 开了之后代码块会自动折叠（if/function 等）干扰阅读，保留写法以避免忘记。
  -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  -- vim.wo.foldmethod = 'expr'

  -- 检查当前语言有没有 treesitter 的缩进规则（即 nvim-treesitter 提供的 indents.scm 文件）
  -- 如果有，则用 treesitter 的缩进算法代替 vim 默认的（indentexpr/cindent/autoindent）。
  -- 如果没有，则不干预，保持 vim 原生的缩进方式。
  if vim.treesitter.query.get(language, 'indents') ~= nil then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

local available_parsers = plugin_treesitter.get_available()
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then
      return
    end

    local installed_parsers = plugin_treesitter.get_installed 'parsers'
    local parserNotInstalled = not vim.tbl_contains(installed_parsers, language)
    local parserAvailable = vim.tbl_contains(available_parsers, language)

    if parserNotInstalled and parserAvailable then
      plugin_treesitter.install(language):await(function()
        treesitter_try_attach(buf, language)
      end)
      return
    end

    treesitter_try_attach(buf, language)
  end,
})
