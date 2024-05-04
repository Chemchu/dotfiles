{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      # Packages needed for Java
      temurin-bin-17
    ];
  };

  programs.nixvim = {
    plugins = {
      lsp.servers = {
        java-language-server = {
          enable = true;
        };
      };
    };
  };
}

