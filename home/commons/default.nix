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
    #teams-for-linux
    postman
    dbeaver-bin
    thunderbird-bin
  ];

}
