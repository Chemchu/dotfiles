{...}: {
  imports = [../../../nixos/hosts/framework13/configuration.nix];
  flake.nixosModules.framework13Hardware = import ../../../nixos/hosts/framework13/hardware-configuration.nix;
}
