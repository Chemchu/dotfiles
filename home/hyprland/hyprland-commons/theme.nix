{
  pkgs,
  ...
}: let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "Iosevka Nerd Font"
      "Ubuntu"
      "UbuntuMono"
      "CascadiaCode"
      "FantasqueSansMono"
      "FiraCode"
      "Mononoki"
    ];
  };

  font = {
    name = "Iosevka Nerd Font";
    package = nerdfonts;
    size = 11;
  };
  cursorTheme = {
    name = "Bibata-Modern-Classic";
    size = 26;
    package = pkgs.bibata-cursors;
  };
  iconTheme = {
    name = "MoreWaita";
    package = pkgs.morewaita-icon-theme;
  };
in {
  home = {
    packages = with pkgs; [
      cantarell-fonts
      font-awesome
      font.package
      cursorTheme.package
      iconTheme.package
      adwaita-icon-theme
      papirus-icon-theme
    ];

    sessionVariables = {
      XCURSOR_THEME = cursorTheme.name;
      XCURSOR_SIZE = "${toString cursorTheme.size}";
    };
    pointerCursor =
      cursorTheme
      // {
        gtk.enable = true;
        x11.enable = true;
      };
  };

  fonts.fontconfig.enable = true;
}

