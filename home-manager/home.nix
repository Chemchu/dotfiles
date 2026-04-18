{pkgs, ...}: {
  imports = [
    ./commons
    ./hyprland
  ];

  home.username = "gus";
  home.homeDirectory = "/home/gus";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    htop
    btop
  ];

  home.shellAliases = {
    cd = "z";
    ls = "eza";
  };

  programs.home-manager.enable = true;
}
