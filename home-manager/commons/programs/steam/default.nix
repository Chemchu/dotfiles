{ pkgs, ... }:
{
  home.packages = [
    # Other packages...
    pkgs.steam
    pkgs.gamescope
  ];
}
