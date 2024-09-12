{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # Mainly for Rust and C/C++ development
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
    openssl
    alsa-lib
    systemd
    xorg.libX11
    xorg.libXcursor
    xorg.libxcb
    xorg.libxcb.dev
    xorg.libXi
    libxkbcommon
    cmake
    cairo
    ninja
    pugixml
    libgcc
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
