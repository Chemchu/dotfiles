{
  pkgs,
  config,
  ...
}:
{
  home = {
    packages = with pkgs; [
      # Rust dependencies
      cargo-watch
      bacon
      gcc
      #surrealist # Database manager
      #surrealdb # Database engine
      cargo-tauri
    ];

    sessionVariables = {
      # To make rust work when building
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
    };
  };
}
