{
  pkgs,
  config_path,
  ...
} :
let
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dharmx/walls/refs/heads/main/m-26.jp/a_lighthouse_with_a_large_cloud_of_pink_clouds.jpg";
    # replace this with the SHA256 hash of the image file
    sha256 = "04yvx7634g34q4c43793ib66gsrnnav9raih0mk8pd37fvhah7af";
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
