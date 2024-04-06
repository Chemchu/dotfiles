{pkgs, ...}:
{

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;   
  };

  home.packages = with pkgs; [
    font-awesome
  ];

  home.file.".config/waybar/style.css".source = ./style.css;
  home.file.".config/waybar/config".source = ./config;
  home.file.".config/waybar/scripts".source = ./scripts;
  home.file.".config/waybar/scripts".recursive = true;
}
