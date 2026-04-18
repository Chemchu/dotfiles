{
  self,
  inputs,
  ...
}: let
  inherit (inputs) nixpkgs rust-overlay wallpaper lock-wallpaper zen-browser;
in {
  systems = ["x86_64-linux"];

  flake.nixosConfigurations.framework = nixpkgs.lib.nixosSystem {
    specialArgs = {
      inherit inputs;
      system_name = "framework";
      config_path = ".config";
    };
    modules = [
      {nixpkgs.hostPlatform = "x86_64-linux";}
      self.nixosModules.framework13Configuration
      {home-manager.extraSpecialArgs = {inherit inputs wallpaper lock-wallpaper;};}
      ({pkgs, ...}: {
        nixpkgs.overlays = [rust-overlay.overlays.default];
        environment.systemPackages = with pkgs; [
          rust-bin.stable.latest.default
          zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
        ];
      })
      self.nixosModules.niri
    ];
  };
}
