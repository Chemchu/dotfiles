{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [ 
    waybar
    mako
    libnotify
    swww
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
          exec-once = [
            "swww init" # Exec Swww to have wallpaper working
            "swww img ~/.config/wallpaper/wallpaper" # Set wallpaper
            "waybar" # Waybar top bar
            "mako" # Notification daemon
          ];
    };
  };
    home.file."~/.config/hypr/hyprland.conf".source = ./hyprland.conf;
}
