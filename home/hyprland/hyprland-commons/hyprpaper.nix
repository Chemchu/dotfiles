{
  pkgs,
  config_path,
  ...
} :
let
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dharmx/walls/refs/heads/main/anime/a_door_with_a_doorway_and_shoes_on_the_ground.jpg";
    # replace this with the SHA256 hash of the image file
    sha256 = "18zfqax82kvhbi3n5xp9ab9yq64akqhqgbhn3lj7ac4gq113lcva";
  };
in
{
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
