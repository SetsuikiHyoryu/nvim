-- Vue 相关的配置参考：<https://github.com/vuejs/language-tools/wiki/Neovim>
local vue_lsp_location = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
local vue_plugin = {
  name = '@vue/typescript-plugin',
  -- 如果项目路径下的 `node_modules` 中安装了 `@vue/typescript-plugin`，则 `location` 可以为任意值
  location = vue_lsp_location,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

return {
  init_options = {
    -- 一些大型 TS 项目需要分配较多内存以避免 ts_ls 崩溃。
    -- 若非开发这些项目，最好将这里注释。
    maxTsServerMemory = 8192,

    plugins = {
      vue_plugin,
    },
  },

  -- 为 `ts_ls` 配置 `vue_ls` 只是让 `ts_ls` 在 Vue 文件里生效。
  -- 如果要让 Vue 文件中的 HTML 和 CSS 的 LSP 功能生效，
  -- `vue_ls` 本身也需要作为服务器启动。
  --
  -- HTML 和 CSS 的 LSP 增加 `vue` 文件类型后自身也能正常生效，
  -- 但是会影响到模版中非自身相关的区域，会造成和其他 LSP 重复或覆盖其行为的问题，
  -- 所以不应该让 HTML 和 CSS 的 LSP 识别 Vue 文件。
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'vue',
  },
}
