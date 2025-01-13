{
  pkgs,
  config_path,
  ...
}: let
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dharmx/walls/refs/heads/main/jackb/a_screenshot_of_a_computer_02.jpg";
    # replace this with the SHA256 hash of the image file
    sha256 = "1v5q3181c1gj7w9ah154wxghbi6zis4hz8aigpc1r7r320096pak";
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
