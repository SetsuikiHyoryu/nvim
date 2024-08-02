require 'lspconfig'.jdtls.setup {
  -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    -- 'java',
    'E:\\SOFT\\programming\\programming-language\\Java\\jdk-20\\bin\\java', -- or '/path/to/java17_or_newer/bin/java'
    -- 'E:\\SOFT\\programming\\programming-language\\Java\\jdk-14.0.2\\bin\\java', -- or '/path/to/java17_or_newer/bin/java'
    -- 'C:\\Users\\Hyoryu\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\jdtls.cmd',
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- 💀
    'jar',
    'C:\\Users\\Hyoryu\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\plugins\\org.eclipse.equinox.launcher_*.jar',

    -- 💀
    '-configuration', 'C:\\Users\\Hyoryu\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\config_win',

    -- 💀
    -- See `data directory configuration` section in the README
    '-data', '$HOME\\java\\workspace',
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = function(fname)
    return require("lspconfig").util.root_pattern("pom.xml", "gradle.build", ".git")(fname) or vim.fn.getcwd()
  end,
}
