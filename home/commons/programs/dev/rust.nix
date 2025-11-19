{
  pkgs,
  config,
  ...
}: {
  home = {
    packages = with pkgs; [
      bacon
      cargo-tauri
    ];

    sessionVariables = {
      # To make rust work when building
      CARGO_HOME = "${config.xdg.dataHome}/cargo";
    };
  };
}
