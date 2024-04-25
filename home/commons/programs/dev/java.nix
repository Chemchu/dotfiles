{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      # Packages needed for Java
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

