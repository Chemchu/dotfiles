{
  pkgs,
  config_path,
  ...
}: let
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dharmx/walls/refs/heads/main/decay/a_car_on_fire_at_night.jpg";
    # replace this with the SHA256 hash of the image file
    sha256 = "1yzslgkkxigf6hn2xpb4xm4sc93ng7z7r3lb1hbqsgd7wpy5sn4p";
  };
in {
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
