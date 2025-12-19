-- LSP 包管理器。
vim.pack.add { 'https://github.com/mason-org/mason.nvim' }
require('mason').setup()

-- 这个插件让 `lua_ls` 可以识别 Neovim 和插件接口。
vim.pack.add { 'https://github.com/folke/lazydev.nvim' }

require('lazydev').setup {
  -- See the configuration section for more details
  -- Load luvit types when the `vim.uv` word is found
  { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
}

-- LSP 配置集。
-- 使用这个插件可以不用手动调用 `vim.lsp.config`，
-- 但如果需要自定义配置还是需要手动调用。
vim.pack.add { 'https://github.com/neovim/nvim-lspconfig' }

-- 插件（这里是 `nvim-lspconfig`）优先级高于 `runtimepath/lsp/`（似乎是加载顺序），
-- 两边配置中的对象会合并，但数组好像是直接覆盖。
-- 所以修改 `filetypes` 只能在这里（也就是 `nvim-lspconfig` 加载后）完整覆写一遍：
for lsp, config in pairs {
  -- 为 `ts_ls` 配置 `vue_ls` 只是让 `ts_ls` 在 Vue 文件里生效。
  -- 如果要让 Vue 文件中的 HTML 和 CSS 的 LSP 功能生效，
  -- `vue_ls` 本身也需要作为服务器启动。
  --
  -- HTML 和 CSS 的 LSP 增加 `vue` 文件类型后自身也能正常生效，
  -- 但是会影响到模版中非自身相关的区域，会造成和其他 LSP 重复或覆盖其行为的问题，
  -- 所以不应该让 HTML 和 CSS 的 LSP 识别 Vue 文件。
  ts_ls = {
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
      'vue',
    },
  },
} do
  vim.lsp.config(lsp, config)
end

-- 启动 LSP。
for _, server in ipairs {
  'lua_ls',
  'rust_analyzer',
  'gopls',
  'clangd',
  'ts_ls',
  'cssls',
  'html',
  'vue_ls',
  'pyright',
  'jdtls',
  'tinymist',
} do
  vim.lsp.enable(server)
end

-- 自定义 LSP 配置。
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('LSPAttachCustom', { clear = true }),
  callback = function(attach)
    local snacks_picker = require('snacks').picker
    local client = vim.lsp.get_client_by_id(attach.data.client_id)

    -- Keymaps
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = attach.buf, desc = 'LSP: ' .. desc })
    end

    map('grd', snacks_picker.lsp_definitions, '[G]oto [D]efinition')
    map('grD', snacks_picker.lsp_declarations, '[G]oto [D]eclaration')
    map('gri', snacks_picker.lsp_implementations, '[G]oto [I]mplementation')
    map('grr', snacks_picker.lsp_references, '[G]oto [R]eferences')
    map('grt', snacks_picker.lsp_type_definitions, '[G]oto [T]ype Definition')

    -- Foloding
    if client and client:supports_method 'textDocument/foldingRange' then
      local window = vim.api.nvim_get_current_win()
      vim.wo[window][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    -- Inlay Hint（参数提示）
    if client and client:supports_method 'textDocument/inlayHint' then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = attach.buf })
      end, '[T]oggle Inlay [H]ints')
    end

    -- LSP 下线时清除引用。
    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('LspDetachCustom', { clear = true }),
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end,
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = true },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = true, -- 显示来源。
    spacing = 2,
  },
}
