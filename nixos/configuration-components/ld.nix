{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    curl
    wget
    pkg-config
    dbus
    openssl_3
    glib
    gtk3
    libsoup
    webkitgtk
    librsvg
    # Add more packages as needed
  ];

  environment.variables = {
    LD_LIBRARY_PATH = lib.mkForce "${pkgs.lib.makeLibraryPath [
      pkgs.vulkan-tools
      pkgs.vulkan-headers
      pkgs.vulkan-loader
      pkgs.openssl
      pkgs.xorg.libX11
      pkgs.gtk3
    ]}:$LD_LIBRARY_PATH";

    # Concatenate XDG_DATA_DIRS with the current environment value
    XDG_DATA_DIRS = lib.mkForce "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS";
  };
}
