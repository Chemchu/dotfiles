{
  pkgs,
  config_path,
  ...
}: let
  wallpaper = pkgs.fetchurl {
    url = "https://data.ukiyo-e.org/mfa/images/sc209131.jpg";
    # replace this with the SHA256 hash of the image file
    sha256 = "0wycc8773n85mf6mnwmma6s2r0j7qhgr6cip69l69kb0xc86sznf";
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
