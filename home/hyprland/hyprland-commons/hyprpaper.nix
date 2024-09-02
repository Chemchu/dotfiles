{
  pkgs,
  config_path,
  ...
} :
let
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dharmx/walls/main/anime/a_cartoon_of_a_man_standing_in_a_desert.jpg";
    # replace this with the SHA256 hash of the image file
    sha256 = "01lnwymp2zzpxnk41yhl843p0q0pvi3jcc7pawk18myy9kdn023s";
  };
in
{
  home.packages = with pkgs; [
    hyprpaper
  ];

  home.file."${config_path}/hypr/background.jpg".source = wallpaper;
  home.file."${config_path}/hypr/hyprpaper.conf".text = ''
    preload = ~/${config_path}/hypr/background.jpg
    wallpaper = , ~/${config_path}/hypr/background.jpg
    ipc = on
  '';
}
