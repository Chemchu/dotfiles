{
  # This is installed system-wide, so it's not necessary to install it in the user profile.
  services.flatpak = {
    enable = true;
    packages = [
      #"io.dbeaver.DBeaverCommunity"
      #"com.github.IsmaelMartinez.teams_for_linux"
      "app.zen_browser.zen"
    ];
    overrides = {
      global = {
        Context.filesystems = [
          "home"
        ];
      };
      "app.zen_browser.zen".Context = {
        filesystems = [
          "home"
        ];
      };
    };
  };
}
