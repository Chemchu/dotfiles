{
  pkgs,
  ...
}
:
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
    xorg.libXi
    libxkbcommon

    cmake
    cairo
    ninja
    pugixml
    libgcc
    hyprwayland-scanner
  ];
}
