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
}
