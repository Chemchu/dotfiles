{
  pkgs,
  ...
}: {
  imports = [
    ./hypr
    ./rofi
    ./waybar
  ];

  home = {
    packages = with pkgs; [
      ags
    ];
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 26;
  };
}
