-- Mac 上用 `openjdk` 会报错说找不到 `Object`, `String` 等类型，原因不明。
-- 所以 Mac 上也要安装 Oracle 官方 JDK。
return {
  -- 为 `jdtsl` 指定 JDK 需要重写 `cmd` 并指定 `--java-executable`。
  cmd = {
    'jdtls',
    '--java-executable',
    os.getenv 'JAVA_HOME_FOR_JDTLS' .. '/bin/java',
  },

  -- `settings.java.configuration.runtimes` 说是可以让 Java 自己找匹配项目的版本。
  -- 但是我没实际感受出差别，不配置这个也可以在 Java 17 的项目上正常启动 `jdtls`。
  --
  -- 提到这个配置的位置：
  -- <https://github.com/mfussenegger/nvim-jdtls?tab=readme-ov-file#java-xy-language-features-are-not-available>
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-17',
            path = os.getenv 'JAVA_HOME_17',
          },
          {
            name = 'JavaSE-24',
            path = os.getenv 'JAVA_HOME_24',
          },
        },
      },
    },
  },
}
