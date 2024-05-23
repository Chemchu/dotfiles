{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      # Packages needed for Java
      jdk17
      jdt-language-server
      jetbrains.idea-community
    ];
  };

  programs.nixvim = {
    plugins = {
      nvim-jdtls = {
        enable = true;
        cmd = [
          "${pkgs.jdt-language-server}/bin/jdt-language-server"
        ];
      };

      lsp = {
        enable = true;
        servers = {
          java-language-server = { enable = true; };
        };
      };
    };
  };
}
