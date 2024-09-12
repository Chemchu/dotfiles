{
  pkgs,
  ...
}
:
{
  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";

    # Env for nh CLI
    FLAKE = "/home/gus/dotfiles";

    GTK_IM_MODULE= "ibus";
  };

  # Adding zsh also in configuration.nix to source it
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

}
