{pkgs, ...}:
{
  # Adds .xinitrc to $HOME to init Hyprland on startup
  home.file.".xinitrc".source = ./xinitrc;
}
