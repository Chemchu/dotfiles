{
  description = "Gus NixOs cool configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs"; # --> Stable channel
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
    };
    lf-icons = {
      url = "github:gokcehan/lf";
      flake = false;
    };
    nh = {
      url = "github:notashelf/nh?rev=29f74df5734cdaf41edc81aaa25e6ff0a73fe78f"; # Using the specific commit
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
  };
  outputs = inputs @ {
    home-manager,
    nixpkgs,
    rust-overlay,
    nix-flatpak,
    nh,
    ...
  }: let
    createConfiguration = name:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          system_name = name;
          config_path = ".config";
        };
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
          (
            {pkgs, ...}: {
              nixpkgs.overlays = [
                rust-overlay.overlays.default
              ];
              environment.systemPackages = with pkgs; [
                rust-bin.stable.latest.default
                nh.packages.${pkgs.system}.default
              ];
            }
          )
        ];
      };
  in {
    nixosConfigurations = {
      framework = createConfiguration "framework";
    };
  };
}
