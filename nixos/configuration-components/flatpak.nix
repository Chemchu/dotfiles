{
  # This is installed system-wide, so it's not necessary to install it in the user profile.
  services.flatpak.enable = true;
  services.flatpak.packages = [
    "com.discordapp.Discord"
    "io.dbeaver.DBeaverCommunity"
  ];
}
