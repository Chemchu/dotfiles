{
  pkgs,
  ...
} :
{
  home.packages = with pkgs; [
    waybar
    jq
    playerctl
  ];

  home.file.".config/waybar/scripts".recursive = true;
  home.file.".config/waybar/scripts".source = ./scripts;
  home.file.".config/waybar/config".source = ./config;
  home.file.".config/waybar/style.css".source = ./style.css;
}
