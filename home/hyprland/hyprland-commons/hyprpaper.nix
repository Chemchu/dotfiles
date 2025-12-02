{
  pkgs,
  config_path,
  wallpaper,
  ...
}: {
  home = {
    packages = with pkgs; [
      hyprpaper
    ];
    file."${config_path}/hypr/background.jpg".source = wallpaper;
    file."${config_path}/hypr/hyprpaper.conf".text = ''
      preload = ~/${config_path}/hypr/background.jpg
      wallpaper = , ~/${config_path}/hypr/background.jpg
      ipc = on
    '';
  };
}
