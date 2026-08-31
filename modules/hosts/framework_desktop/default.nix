{...}: {
  imports = [../../../nixos/hosts/framework_desktop/configuration.nix];
  flake.nixosModules.frameworkDesktopHardware = import ../../../nixos/hosts/framework_desktop/hardware-configuration.nix;
}
