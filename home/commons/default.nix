{
  pkgs,
  ...
}:
{
  imports = [
    ./programs
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    feh
    mpv
    spotify
    jq
    postman
    dbeaver-bin
    thunderbird-bin
    beekeeper-studio
  ];

}
