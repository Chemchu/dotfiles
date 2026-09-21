{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      gnumake
      stlink
      gcc-arm-embedded
    ];
  };
}
