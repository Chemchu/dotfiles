{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      cantarell-fonts
      font-awesome
      bibata-cursors
      adwaita-icon-theme
      papirus-icon-theme
      morewaita-icon-theme
    ];

    sessionVariables = {
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "26";
    };
  };

  fonts.fontconfig.enable = true;
}

