{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    bun
    dart-sass
    fd
    brightnessctl
    inputs.matugen.packages.${system}.default
    slurp
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    networkmanager
    gtk3
  ];

  programs.ags = {
    enable = true;
    configDir = ../ags/ags-config;
    extraPackages = with pkgs; [
      accountsservice
    ];
  };
}
