{ pkgs, lib, ... }:
let
  buildInputs = [
      pkgs.vulkan-tools
      pkgs.vulkan-headers
      pkgs.vulkan-loader
      pkgs.openssl
      pkgs.gtk3
      pkgs.pkg-config
      pkgs.libudev-zero
      pkgs.alsa-lib
      pkgs.xorg.libX11
      pkgs.xorg.libXrandr
      pkgs.xorg.libXcursor
      pkgs.xorg.libXi
      pkgs.libxkbcommon
      pkgs.libglvnd
      pkgs.glibc
      pkgs.libsoup_3
      pkgs.webkitgtk_4_1
      pkgs.udev
      pkgs.wayland
  ];
in
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Mainly for Rust and C/C++ development
    curl
    wget
    dbus
    openssl_3
    glib
    libsoup
    librsvg
    cmake
    cairo
    ninja
    pugixml
    libgcc
    glibc
    libsoup_3
    webkitgtk_4_1
  ] ++ buildInputs;

  environment.variables = {
    LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;

    # Concatenate XDG_DATA_DIRS with the current environment value
    PKG_CONFIG_PATH = "${pkgs.alsa-lib.dev}/lib/pkgconfig:${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.systemd.dev}/lib/pkgconfig";
    XDG_DATA_DIRS = lib.mkForce "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS";
  };
}
