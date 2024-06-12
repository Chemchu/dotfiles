{
  pkgs,
  ...
}: {
  imports = [
    ./hypr
    ./rofi
    ./waybar
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 26;
  };
}
