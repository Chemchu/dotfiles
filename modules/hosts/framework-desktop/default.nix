{...}: {
  imports = [../../../nixos/hosts/framework-desktop/configuration.nix];
  flake.nixosModules.frameworkDesktopHardware = import ../../../nixos/hosts/framework-desktop/hardware-configuration.nix;
}
