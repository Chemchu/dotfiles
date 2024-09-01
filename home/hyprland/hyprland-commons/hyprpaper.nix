{
  pkgs,
  config_path,
  ...
} :
let
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dharmx/walls/main/painting/a_bridge_with_a_view_of_a_city.jpg";
    # replace this with the SHA256 hash of the image file
    sha256 = "0lkhd05bcfd50syq7hlmr94y6w3k3xlll6cd4fdbnd203d76vm4v";
  };
in
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  # Here I import all my wallpapers
  home.file."${config_path}/hypr/background.jpg".source = wallpaper;
  home.file."${config_path}/hypr/hyprpaper.conf".text = ''
    preload = ~/${config_path}/hypr/background.jpg
    wallpaper = , ~/${config_path}/hypr/background.jpg
    ipc = on
  '';
}
