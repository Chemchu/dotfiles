{
  pkgs,
  ...
}:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages

    # Vulkan
    vulkan-tools
    vulkan-headers
    vulkan-loader
    vulkan-utility-libraries
    vulkan-validation-layers

    # Mainly for Rust development
    pkg-config
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
    hyprwayland-scanner

    # Additional libraries from the original script
    nss
    sane-backends
    nspr
    zlib
    libglvnd
    qt5.qtbase
    qt5.qtsvg
    qt5.qtdeclarative
    qt5.qtwayland
    stdenv.cc.cc
  ];

  # Additional environment variables
  #environment.variables = {
  #  NIX_LD_LIBRARY_PATH = builtins.concatStringsSep ":" (map (lib: lib.dev)/usr/lib) [
  #    pkgs.nss
  #    pkgs.sane-backends
  #    pkgs.nspr
  #    pkgs.zlib
  #    pkgs.libglvnd
  #    pkgs.qt5.qtbase
  #    pkgs.qt5.qtsvg
  #    pkgs.qt5.qtsvg
  #    pkgs.qt5.qtdeclarative
  #    pkgs.qt5.qtwayland
  #    pkgs.stdenv.cc.cc
  #  ];

  #  #NIX_LD = builtins.readFile "${pkgs.stdenv.cc}/nix-support/dynamic-linker";
  #  QT_PLUGIN_PATH = "${pkgs.qt5.qtbase}/${pkgs.qt5.qtbase.qtPluginPrefix}:${pkgs.qt5.qtwayland.bin}/${pkgs.qt5.qtbase.qtPluginPrefix}";
  #  QML2_IMPORT_PATH = "${pkgs.qt5.qtdeclarative.bin}/${pkgs.qt5.qtbase.qtQmlPrefix}:${pkgs.qt5.qtwayland.bin}/${pkgs.qt5.qtbase.qtQmlPrefix}";
  #};
}
