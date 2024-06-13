{ inputs, pkgs, ... }:
{
  # add the home manager module
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    sass
    brightnessctl
  ];

  programs = {
    ags = {
      enable = true;

      # null or path, leave as null if you don't want hm to manage the config
      configDir = null;

      # additional packages to add to gjs's runtime
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };
  };

  # AGS configuration project
  home.file.".config/ags".source = ./ags-config;
  home.file.".config/ags".recursive = true;

}
