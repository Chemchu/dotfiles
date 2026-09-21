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
      libx11
      libxcursor
      libxrandr
      libxi
    ];

    sessionVariables = {
      PKG_CONFIG_PATH = lib.makeSearchPathOutput "dev" "lib/pkgconfig" (with pkgs; [
        wayland
        libxkbcommon
        alsa-lib
        udev
      ]);

      LD_LIBRARY_PATH = lib.makeLibraryPath (with pkgs; [
        vulkan-loader
        wayland
        libxkbcommon
      ]);
    };
  };
}
