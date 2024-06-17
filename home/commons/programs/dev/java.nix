{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      # Packages needed for Java
      jdk17
      jdt-language-server
      jetbrains.idea-community-bin
      lombok
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
          "-settings /home/gus/ssg/facsa/waternology/tools/apache-maven-3.8.4/conf/settings.xml"
        ];
      };

      lsp = {
        enable = true;
        servers = {
          java-language-server = {enable = true;};
        };
      };
    };
  };
}
