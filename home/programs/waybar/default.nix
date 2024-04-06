{pkgs, ...}:
{

  #programs.waybar = {
  #  enable = true;
  #  package = pkgs.waybar;   
  #};

  home.packages = with pkgs; [
    font-awesome # --> It's here because it's the closest to weather.py which was not able to render emojis
    playerctl
    #swaylock
    swaylock-effects
    libappindicator
    xdg-desktop-portal # --> Remove in case this causes problems
    xdg-desktop-portal-gtk # --> Remove in case this causes problems
  ];

  home.file.".config/waybar/style.css".source = ./style.css;
  home.file.".config/waybar/config".source = ./config;
  home.file.".config/waybar/scripts".source = ./scripts;
  home.file.".config/waybar/scripts".recursive = true;
  home.file.".config/swaylock/config".source = ./swaylock-config;
  home.file.".config/swaylock/wallpaper.jpg".source = ../../wallpapers/swaylock.jpg;

}
