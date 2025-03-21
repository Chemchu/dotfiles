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
    warp-terminal
    zoom-us
    bucklespring-libinput
    flyctl
    jq
    postman
    thunderbird-bin
    libreoffice
    godot_4
    blender
    discord
    bottles
    unzip
  ];

  home.file = {
    ".config/electron-flags.conf".text = ''
      --ozone-platform-hint=auto
      --enable-features=UseOzonePlatform
      --ozone-platform=wayland
    '';
    ".config/bks-flags.conf".text = ''
      --ozone-platform-hint=auto
      --enable-features=UseOzonePlatform
      --ozone-platform=wayland
    '';
  };
}
