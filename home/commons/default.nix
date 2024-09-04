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
    ffmpeg
    feh
    mpv
    spotify
    jq
    postman
    thunderbird-bin
    libreoffice
  ];

  home.file.".config/bks-flags.conf".text = ''
    --ozone-platform-hint=auto
    --enable-features=UseOzonePlatform
  '';

}
