{
  self,
  inputs,
  ...
}: let
  inherit (inputs) nixpkgs rust-overlay zen-browser;
in {
  systems = ["x86_64-linux"];

  flake.nixosConfigurations.framework-desktop = nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
      system_name = "framework-desktop";
      config_path = ".config";
    };
    modules = [
      {nixpkgs.hostPlatform = "x86_64-linux";}
      self.nixosModules.frameworkDesktopConfiguration
      self.nixosModules.niri
      {home-manager.extraSpecialArgs = {inherit inputs;};}
      ({pkgs, ...}: {
        nixpkgs.overlays = [rust-overlay.overlays.default];
        environment.systemPackages = with pkgs; [
          rust-bin.stable.latest.default
          zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
      })
    ];
  };
}
