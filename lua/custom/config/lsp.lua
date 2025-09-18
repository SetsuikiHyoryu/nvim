-- Brief aside: **What is LSP?**
--
-- LSP is an initialism you've probably heard, but might not understand what it is.
--
-- LSP stands for Language Server Protocol. It's a protocol that helps editors
-- and language tooling communicate in a standardized fashion.
--
-- In general, you have a "server" which is some tool built to understand a particular
-- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
-- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
-- processes that communicate with some "client" - in this case, Neovim!
--
-- LSP provides Neovim with features like:
--  - Go to definition
--  - Find references
--  - Autocompletion
--  - Symbol Search
--  - and more!
--
-- Thus, Language Servers are external tools that must be installed separately from
-- Neovim. This is where `mason` and related plugins come into play.
--
-- If you're wondering about lsp vs treesitter, you can check out the wonderfully
-- and elegantly composed help section, `:help lsp-vs-treesitter`

--  This function gets run when an LSP attaches to a particular buffer.
--    That is to say, every time a new file is opened that is associated with
--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--    function will be executed to configure the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  callback = function(event)
    -- NOTE: Remember that Lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

    -- Find references for the word under your cursor.
    map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
    ---@param client vim.lsp.Client
    ---@param method vim.lsp.protocol.Method
    ---@param bufnr? integer some lsp support methods only in specific files
    ---@return boolean
    local function client_supports_method(client, method, bufnr)
      if vim.fn.has 'nvim-0.11' == 1 then
        return client:supports_method(method, bufnr)
      else
        return client.supports_method(method, { bufnr = bufnr })
      end
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    -- if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
    --   local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
    --   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    --     buffer = event.buf,
    --     group = highlight_augroup,
    --     callback = vim.lsp.buf.document_highlight,
    --   })
    --
    --   vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    --     buffer = event.buf,
    --     group = highlight_augroup,
    --     callback = vim.lsp.buf.clear_references,
    --   })
    --
    --   vim.api.nvim_create_autocmd('LspDetach', {
    --     group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
    --     callback = function(event2)
    --       vim.lsp.buf.clear_references()
    --       vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
    --     end,
    --   })
    -- end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  -- [[deprecated]] <https://github.com/nvim-lua/kickstart.nvim/pull/1550>
  -- underline = { severity = vim.diagnostic.severity.ERROR },
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    -- [[deprecated]] <https://github.com/nvim-lua/kickstart.nvim/pull/1550>
    -- format = function(diagnostic)
    --   local diagnostic_message = {
    --     [vim.diagnostic.severity.ERROR] = diagnostic.message,
    --     [vim.diagnostic.severity.WARN] = diagnostic.message,
    --     [vim.diagnostic.severity.INFO] = diagnostic.message,
    --     [vim.diagnostic.severity.HINT] = diagnostic.message,
    --   }
    --   return diagnostic_message[diagnostic.severity]
    -- end,
  },
}

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},

  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        check = {
          command = 'clippy',
        },
      },
    },
  },

  lua_ls = {
    -- cmd = {...},
    -- filetypes = { ...},
    -- capabilities = {},
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },

  -- [[deprecated]]: `vue_ls` 更新至v3.0.0 (2025-07-02) 后不再支持使用
  --
  --  默认使用项目路径下 `node_modules` 中的 `typescript`，采用全局的会较为麻烦，如有需要可参考 nvim-lspconfig 官网
  --  Volar 2.0+ 不再支持托管 TypeScript。如果使用旧版 Volar 托管，需要禁用 tsserver。
  --  See: https://github.com/kshksdrt/language-tools/blob/76fdd2c549f230c89edc94b422ecd87e74578725/README.md#hybrid-mode-configuration-requires-vuelanguage-server-version-200
  -- ts_ls = (function()
  --   local vue_lsp_location = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
  --   return {
  --     -- See: https://github.com/typescript-language-server/typescript-language-server/blob/master/docs/configuration.md#initializationoptions
  --     init_options = {
  --       -- 一些大型 TS 项目需要分配较多内存以避免 ts_ls 崩溃。若非开发这些项目中，应将这里注释。
  --       maxTsServerMemory = 8192,
  --
  --       -- Volar 2.0+ 不会管理 `.vue` 的 `<script>` 块中的 TypeScript，因此 tsserver 需要调用 Volar 插件以认出 `.vue`
  --       plugins = {
  --         {
  --           name = '@vue/typescript-plugin',
  --           -- 如果项目路径下的 `node_modules` 中安装了 `@vue/typescript-plugin`，则 `location` 可以为任意值
  --           location = vue_lsp_location,
  --           languages = { 'vue' },
  --         },
  --       },
  --     },
  --
  --     filetypes = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'vue' },
  --   }
  -- end)(),

  -- 根据 `vue_ls` 2025-07-23 时间点的 wiki 说明，
  -- v3.0.0 之后不能搭配 `ts_ls` 只能搭配 `vtsls` 使用，
  -- 因为 `ts_ls` 不能处理 `typescript.tsserverRequest` 命令。
  -- See: <https://github.com/vuejs/language-tools/wiki/Neovim>
  vtsls = (function()
    local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'

    local vue_plugin = {
      name = '@vue/typescript-plugin',
      location = vue_language_server_path,
      languages = { 'vue' },
      configNamespace = 'typescript',
    }

    return {
      settings = {
        typescript = {
          tsserver = {
            -- 一些大型 TS 项目需要分配较多内存以避免 ts_ls 崩溃。若非开发这些项目中，应将这里注释。
            maxTsServerMemory = 8192,
          },
        },

        vtsls = {
          tsserver = {
            globalPlugins = { vue_plugin },
          },
        },
      },

      -- `vtsls` 和也提供 TypeScript LSP，所以不要和 `ts_ls` 重复使用。
      -- 这里仅让 `vtsls` 作用于 Vue 文件。
      filetypes = { 'vue' },
    }
  end)(),

  tinymist = {
    single_file_support = true,

    root_dir = function()
      return vim.fn.getcwd()
    end,

    -- https://github.com/Myriad-Dreamin/tinymist/blob/5d8930522f6a1435f7b4c44cc8e5ca56ee4eeeb7/editors/neovim/Configuration.md
    settings = {
      exportPdf = 'never',
    },
  },
}

-- Ensure the servers and tools above are installed
--
-- To check the current status of installed tools and/or manually install
-- other tools, you can run
--    :Mason
--
-- You can press `g?` for help in this menu.
--
-- `mason` had to be setup earlier: to configure its options see the
-- `dependencies` table for `nvim-lspconfig` above.
--
-- You can add other tools here that you want Mason to install
-- for you, so that they are available from within Neovim.
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua', -- Used to format Lua code
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for server_name, config in pairs(servers) do
  vim.lsp.config(server_name, config)
end

---@type MasonLspconfigSettings
---@diagnostic disable-next-line: missing-fields
require('mason-lspconfig').setup {
  automatic_enable = true,
}
