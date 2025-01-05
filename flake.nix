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

    khanelivim.url = "github:Chemchu/nvim-config"; # Nixvim config

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
    };

    lf-icons = {
      url = "github:gokcehan/lf";
      flake = false;
    };
  };

  outputs =
    inputs@{
      home-manager,
      nixpkgs,
      rust-overlay,
      nix-flatpak,
      khanelivim,
      ...
    }:
    {
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
            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [
                  rust-overlay.overlays.default
                ];
                environment.systemPackages = with pkgs; [
                  rust-bin.stable.latest.default
                  khanelivim.packages.${pkgs.system}.default
                ];
              }
            )
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
            (
              { pkgs, ... }:
              {
                nixpkgs.overlays = [
                  rust-overlay.overlays.default
                ];
                environment.systemPackages = with pkgs; [
                  rust-bin.stable.latest.default
                  khanelivim.packages.${pkgs.system}.default
                ];
              }
            )
          ];
        };
      };
    };
}
