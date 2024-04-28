{ pkgs, ... }:
let
  wallpaperImg = pkgs.fetchurl {
    url = "https://images.pexels.com/photos/1287124/pexels-photo-1287124.jpeg";
    # replace this with the SHA256 hash of the image file
    sha256 = "13bbssncmmrsydwgqx8637wyqypklcad9l9fzqc0cpwsl7vi9zi1";
  };
in
{
  imports = [
    ../commons
    ./programs
  ];

  #home.networking.hostName = "gnome"; # Define your hostname.

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gus";
  home.homeDirectory = "/home/gus";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    #(pkgs.writeShellScriptBin "my-hello" ''
    #  echo "Hello, ${config.home.username}!"
    #'')

    pkgs.nerdfonts
    pkgs.neofetch
    pkgs.htop
    pkgs.btop
    pkgs.fortune

  ];

  nixpkgs.config.allowUnfree = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gus/etc/profile.d/hm-session-vars.sh
  #

  home.shellAliases = {
    cd = "z";
  };

  home.file.".config/wallpapers/wallpaper".source = ../wallpapers/sorolla.jpg;

  # ...
  dconf.settings = {
    # ...
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "kitty.desktop"
/*         "code.desktop" */
/*         "org.gnome.Terminal.desktop" */
/*         "spotify.desktop" */
      ];
    };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      workspace-names = [ "Main" ];
    };
    "org/gnome/desktop/background" = {
/*       picture-uri-dark = "file://$(echo $HOME)/.config/wallpapers/wallpaper"; */
      picture-uri = "file://${wallpaperImg}";
      picture-uri-dark = "file://${wallpaperImg}";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file://${wallpaperImg}";
      primary-color = "#3465a4";
      secondary-color = "#000000";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
