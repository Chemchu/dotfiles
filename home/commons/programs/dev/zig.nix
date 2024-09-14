{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      zig
      zls
    ];
  };

  programs.nixvim = {
    plugins = {
      zig = {
        enable = true;
        settings = {
          fmt_autosave = 1;
        };
      };
      lsp-format.enable = true;
      lsp-format.lspServersToEnable = ["zls"];
      lsp.servers = {
        zls = {
          enable = true;
        };
      };
    };
  };
}
