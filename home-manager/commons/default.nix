{pkgs, ...}: {
  imports = [
    ./programs
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ffmpeg
    feh
    mpv
    (spotify.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        sed -i 's|^Exec=spotify|Exec=spotify --ozone-platform=wayland --enable-features=UseOzonePlatform|' \
          $out/share/applications/spotify.desktop
      '';
    }))
    cockatrice
    flyctl
    jq
    postman
    godot_4
    blender
    discord
    unzip
    google-chrome
    cmake
    python3
    thc-hydra
    tcpdump
    wireshark
    mold
    lmstudio
    nmap
    dig
    dnslookup
    claude-code
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
