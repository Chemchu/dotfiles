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
}
