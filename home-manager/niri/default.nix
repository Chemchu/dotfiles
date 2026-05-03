{pkgs, ...}: {
  imports = [];

  home.packages = with pkgs; [
    everforest-cursors
  ];
}
