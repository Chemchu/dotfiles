{
  pkgs,
  config_path,
  ...
}: let
  wallpaper = pkgs.fetchurl {
    url = "https://tbhsqpulyboxxqnluknn.supabase.co/storage/v1/object/public/article_thumbnail//6";
    # replace this with the SHA256 hash of the image file
    sha256 = "168hs83h7njvmqdfii5ndk31piyd88n9175hfcl4391inxrvr9yn";
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
