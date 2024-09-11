-- [[ Configure Treesitter ]]
-- 增加这个配置是因为下载 git 相关的解析器时发生了错误。
-- 根据 `Windows support#How will the parser be downloaded?` 章节的说法，
-- 通过 `git` 下载解析器的行为将被弃用，推荐 Windows 下也使用 `curl` 的方式。
-- See <https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support#which-c-compiler-will-be-used>
require('nvim-treesitter.install').prefer_git = false

-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    'bash',
    'markdown',
    'markdown_inline',
    'typst',
    'diff',
    'query',
    'json',
    'vim',
    'vimdoc',
    'lua',
    'luadoc',
    'c',
    'cpp',
    'rust',
    'go',
    'java',
    'python',
    'html',
    'css',
    'javascript',
    'jsdoc',
    'typescript',
    'tsx',
    'vue',
    'sql',
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },

  indent = { enable = true, disable = {} },
}
