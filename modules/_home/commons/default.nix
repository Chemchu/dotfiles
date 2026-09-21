{pkgs, ...}: {
  imports = [
    ./programs
    ./wallpapers
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    ffmpeg
    feh
    mpv
    (spotify.overrideAttrs (old: {
      postInstall =
        (old.postInstall or "")
        + ''
          sed -i 's|^Exec=spotify|Exec=spotify --ozone-platform=wayland --enable-features=UseOzonePlatform|' \
            $out/share/applications/spotify.desktop
        '';
    }))
    flyctl
    jq
    discord
    unzip
    cmake
    python3
    thc-hydra
    tcpdump
    nmap
    dig
    dnslookup
    wl-clipboard
    devenv
    aseprite
    dua
    ghostty
    opencode
    pciutils
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
