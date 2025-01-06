{
  # This is installed system-wide, so it's not necessary to install it in the user profile.
  services.flatpak.enable = true;
  services.flatpak.packages = [
    "io.dbeaver.DBeaverCommunity"
    "com.github.IsmaelMartinez.teams_for_linux"
  ];
}
