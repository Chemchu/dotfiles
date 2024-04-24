{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-index-database.hmModules.nix-index
    ./dev
    ./lf
    ./hypr
    ./kitty
    ./rofi
    ./waybar
    ./neovim
    ./zellij
    ./zoxide
    ./zsh
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # runs programs without installing them
    nix-index-database.comma.enable = true;
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

      # Other utils
      htop
      ncdu
      sshfs
      tlrc

    ];
  };

  networking.hostName = "gnome"; # Define your hostname.

  config = {
    services.xserver.enable = true;
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    environment.gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gedit # text editor
      epiphany # web browser
      geary # email reader
      gnome-characters
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      yelp # Help view
      gnome-contacts
      gnome-initial-setup
    ]);
    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [
      gnome.gnome-tweaks
    ];
  };

}

