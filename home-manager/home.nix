{pkgs, ...}: {
  imports = [
    ./commons
    ./niri
  ];

  home = {
    username = "gus";
    homeDirectory = "/home/gus";
    stateVersion = "23.11";
    packages = with pkgs; [
      htop
      btop
    ];
    shellAliases = {
      cd = "z";
      ls = "eza";
    };
  };

  programs.home-manager.enable = true;
}
