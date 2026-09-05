{
  pkgs,
  inputs,
  ...
}: {
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
    cockatrice
    flyctl
    jq
    discord
    unzip
    google-chrome
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
    ".config/opencode/opencode.json".text = builtins.toJSON {
      "$schema" = "https://opencode.ai/config.json";
      provider = {
        ollama = {
          npm = "@ai-sdk/openai-compatible";
          name = "Ollama (local)";
          options = {
            baseURL = "http://localhost:11434/v1";
          };
          models = {}; # left empty — the plugin fills this at runtime
        };
      };
    };
    ".config/opencode/plugins/opencode-local-models.js".source =
      inputs.opencode-local-models;
  };
}
