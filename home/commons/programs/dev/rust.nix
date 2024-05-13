{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
  ];
  home = {
    packages = with pkgs; [
      bacon
      cargo
      gcc
      rustc
      rustfmt
      pkg-config
      openssl
      surrealist
      surrealdb
    ];

    sessionVariables = {
      # To make rust work when building
      PKG_CONFIG_PATH= "${pkgs.openssl.dev}/lib/pkgconfig";
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
