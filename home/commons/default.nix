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
    qFlipper
    beekeeper-studio
  ];

  home.file.".config/bks-flags.conf".text = ''
    --ozone-platform-hint=auto
    --enable-features=UseOzonePlatform
  '';

}
