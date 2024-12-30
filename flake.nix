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

    nixvim = {
      url = "github:nix-community/nixvim?ref=2017830";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
    };
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lf-icons = {
      url = "github:gokcehan/lf";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    home-manager,
    nixpkgs,
    nix-index-database,
    rust-overlay,
    nix-flatpak,
    ...
  }: {

    nixosConfigurations = {
      spaceship = nixpkgs.lib.nixosSystem {
        specialArgs = {
            inherit inputs;
            system_name = "spaceship";
            config_path = ".config";
        };
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
          ({pkgs, ...}: {
            nixpkgs.overlays = [
              rust-overlay.overlays.default
            ];
            environment.systemPackages = with pkgs; [
              rust-bin.stable.latest.default
            ];
          })
        ];
      };
      framework = nixpkgs.lib.nixosSystem {
        specialArgs = {
            inherit inputs;
            system_name = "framework";
            config_path = ".config";
        };
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
          ({pkgs, ...}: {
            nixpkgs.overlays = [
              rust-overlay.overlays.default
            ];
            environment.systemPackages = with pkgs; [
              rust-bin.stable.latest.default
            ];
          })
        ];
      };
    };
  };
}
