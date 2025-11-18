{
  pkgs,
  config_path,
  ...
}: let
  wallpaper = pkgs.fetchurl {
    url = "https://github.com/dharmx/walls/blob/main/centered/a_red_object_in_the_sky.jpg?raw=true";
    # url = "https://tbhsqpulyboxxqnluknn.supabase.co/storage/v1/object/public/article_thumbnail//6";
    # replace this with the SHA256 hash of the image file
    sha256 = "13wg4i2ipkxgjmjs8sgkld074a68xq3qd1dbq728rirlib17bwnr";
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
