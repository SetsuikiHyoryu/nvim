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

local servers = {
  'lua_ls',
  'rust_analyzer',
  'gopls',
  'ts_ls',
  'cssls',
  'html',
  'pyright',
  'clangd',
  'tinymist',
  'powershell',
  'jdtls',
}

-- 启动 LSP。
for _, server in ipairs(servers) do
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
