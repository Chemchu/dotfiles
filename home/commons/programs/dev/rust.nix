{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      # Rust dependencies
      cargo-watch
      bacon
      gcc
      #surrealist # Database manager
      #surrealdb # Database engine
    ];

    sessionVariables = {
      # To make rust work when building
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
    };
  };

  #programs.nixvim = {
  #  plugins = {
  #    crates-nvim.enable = true;
  #    lsp-format.lspServersToEnable = ["rust-analyzer"];
  #    lsp.servers = {
  #      rust-analyzer = {
  #        enable = false;
  #        installCargo = true;
  #        installRustc = true;
  #        settings = {
  #          cargo.features = "all";
  #        };
  #      };
  #    };
  #  };
  #};
}
