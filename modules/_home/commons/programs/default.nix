{pkgs, ...}: {
  imports = [
    ./ghostty
    ./guitar
    ./dev
    ./direnv
    ./fastfetch
    ./llama-cpp
    ./heroic_games
    ./yazi
    ./kitty
    ./nvf
    ./obs
    ./mouse
    ./steam
    ./zellij
    ./oxide
    ./zsh
  ];

  programs = {
    home-manager.enable = true;
    llama.enable = true;
  };

  home = {
    packages = with pkgs; [
      # Rust implementations of linux commands
      bat # cat
      bottom # System monitor
      dust
      dua # du
      fd # find
      dysk # df
      procs # ps
      ripgrep
      uutils-coreutils

      # Other utils
      htop
      ncdu
      sshfs
      tlrc
      killall
      openconnect
      lsof
      lm_sensors
      mangohud
      claude-code
    ];
  };
}
