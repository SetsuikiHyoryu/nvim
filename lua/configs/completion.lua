vim.pack.add { 'https://github.com/xzbdmw/colorful-menu.nvim' }
local colorful_menu = require 'colorful-menu'

vim.pack.add { 'https://github.com/saghen/blink.cmp' }

local function lazy_callback()
  require('blink.cmp').setup {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      preset = 'default',

      -- <c-space>  在 Windows 中为输入法中英文切换，
      -- 因此于此另外映射打开二级菜单的行为至插入模式中无动作的 <c-b> 上。
      ['<c-b>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<c-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<c-d>'] = { 'scroll_documentation_down', 'fallback' },

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- 显示详细文档。
      documentation = { auto_show = true, auto_show_delay_ms = 0 },

      -- 高亮补全菜单。
      menu = {
        draw = {
          components = {
            label = {
              text = function(context)
                return colorful_menu.blink_components_text(context)
              end,
              highlight = function(context)
                return colorful_menu.blink_components_highlight(context)
              end,
            },
          },
        },
      },
    },

    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  }
end

vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter' }, {
  group = vim.api.nvim_create_augroup('Completion', { clear = true }),
  -- 执行后自动销毁。即一次性改状态要加，多次切换状态或者执行副作用不加。
  once = true,
  callback = lazy_callback,
})
