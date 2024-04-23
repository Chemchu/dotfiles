{
  pkgs,
  ...
}: {
  imports = [
    ./hypr
    ./rofi
    ./waybar
  ];

  # SDDM + Keyboard
  services.displayManager.sddm = {
    enable = true;
    theme = "${import ./theme.nix { inherit pkgs; }}";
    settings = {
      General.DefaultSession = "wayland.desktop";
      General.DisplayServer = "wayland";
    };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;

    # runs programs without installing them
    nix-index-database.comma.enable = true;
  };

}
