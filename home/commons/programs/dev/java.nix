{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      # Packages needed for Java
      jdk17
    ];
  };

  programs.nixvim = {
    plugins = {
      nvim-jdtls = {
        enable = false;
        data = "${config.xdg.cacheHome}/jdtls/workspace";
        configuration = "${config.xdg.cacheHome}/jdtls/config";
        initOptions = null;
        rootDir = {
          __raw = "require('jdtls.setup').find_root({'.git','mvnw','pom.xml', 'gradlew'})";
        };
        settings = null;
        cmd = [
          "${pkgs.jdt-language-server}/bin/jdtls"
        ];
      };

      lsp = {
        enable = true;
        servers = {
          java_language_server = {enable = true;};
        };
      };
    };
  };
}
