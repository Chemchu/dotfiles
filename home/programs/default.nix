{
  pkgs,
  ...
}: {
  imports = [
    ./dev
    ./lf
    ./hypr
    ./kitty
    ./rofi
    ./waybar
    ./neovim
    ./zoxide
    ./zsh
  ];

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # runs programs without installing them
    # nix-index-database.comma.enable = true;
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
}
