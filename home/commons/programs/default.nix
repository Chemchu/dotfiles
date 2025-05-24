{pkgs, ...}: {
  imports = [
    ./guitar
    ./dev
    ./direnv
    ./evil-helix
    ./lf
    ./kitty
    ./neovim
    ./obs
    ./mouse
    ./steam
    ./zellij
    ./oxide
    ./zsh
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };

  home = {
    packages = with pkgs; [
      # Rust implementations of linux commands
      bat # cat
      bottom # System monitor
      du-dust # du
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
    ];
  };
}
