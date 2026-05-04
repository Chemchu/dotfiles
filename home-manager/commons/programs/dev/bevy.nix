# Bevy game engine native dependencies.
# Without this, `cargo build` fails with "pkg-config not found" or
# "could not find wayland-client" on NixOS — even though the crate looks installed.
# NixOS doesn't expose system libraries to pkg-config automatically, so we do it here.
{
  pkgs,
  lib,
  ...
}: {
  home = {
    packages = with pkgs; [
      pkg-config
      udev
      alsa-lib
      wayland
      libxkbcommon
      vulkan-loader
      xorg.libX11
      xorg.libXcursor
      xorg.libXrandr
      xorg.libXi
    ];

    sessionVariables = {
      # Lets cargo's build scripts find .pc files for wayland, alsa, udev, etc.
      PKG_CONFIG_PATH = lib.makeSearchPathOutput "dev" "lib/pkgconfig" (with pkgs; [
        wayland
        libxkbcommon
        alsa-lib
        udev
      ]);

      # Bevy loads vulkan and wayland dynamically at runtime; they need to be on LD_LIBRARY_PATH.
      LD_LIBRARY_PATH = lib.makeLibraryPath (with pkgs; [
        vulkan-loader
        wayland
        libxkbcommon
      ]);
    };
  };
}
