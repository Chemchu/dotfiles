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

    PKG_CONFIG_PATH = "${pkgs.alsa-lib.dev}/lib/pkgconfig:${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.systemd.dev}/lib/pkgconfig";
    #LD_LIBRARY_PATH = "${pkgs.stdenv.lib.getEnv "LD_LIBRARY_PATH"}:${pkgs.stdenv.lib.getEnv "NIX_LD_LIBRARY_PATH"}";
  };

  # Adding zsh also in configuration.nix to source it
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

}
