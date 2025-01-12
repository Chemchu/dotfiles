{pkgs, ...}: {
  imports = [
    ./programs
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ffmpeg
    feh
    mpv
    spotify
    bucklespring-libinput
    flyctl
    jq
    postman
    thunderbird-bin
    libreoffice
    godot_4
    blender
    discord
  ];

  home.file.".config/bks-flags.conf".text = ''
    --ozone-platform-hint=auto
    --enable-features=UseOzonePlatform
  '';
}
