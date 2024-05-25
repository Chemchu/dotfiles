{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      # Rust dependencies
      bacon
      gcc
      pkg-config
      openssl
      surrealist # Database manager
      surrealdb # Database engine

      # Bevy development
      alsa-lib
      systemd
    ];

    sessionVariables = {
      # To make rust work when building
      PKG_CONFIG_PATH = "${pkgs.alsa-lib.dev}/lib/pkgconfig:${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.systemd.dev}/lib/pkgconfig";
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
    };
  };

  programs.nixvim = {
    plugins = {
      crates-nvim.enable = true;
      lsp-format.lspServersToEnable = ["rust-analyzer"];
      lsp.servers = {
        rust-analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
          settings = {
            cargo.features = "all";
          };
        };
      };
    };
  };
}
