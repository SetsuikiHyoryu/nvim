vim.pack.add {
  {
    src = 'https://github.com/nvim-treesitter/nvim-treesitter',
    version = 'main',
  },
}

-- **Release 0.12 后，`nvim-treesitter` 不需要再手动调用 `setup` 了，**
-- **但不清楚 Windows 下这句是否还要。**
-- **暂时将此句注释。**
--
-- 增加这个配置是因为下载 git 相关的解析器时发生了错误。
-- 根据 `Windows support#How will the parser be downloaded?` 章节的说法，
-- 通过 `git` 下载解析器的行为将被弃用，推荐 Windows 下也使用 `curl` 的方式。
-- See <https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support#which-c-compiler-will-be-used>
-- require('nvim-treesitter.install').prefer_git = false
