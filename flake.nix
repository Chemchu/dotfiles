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

    nvf.url = "github:notashelf/nvf";

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
      ...
    }:
    let
      createConfiguration =
        name:
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
              { pkgs, ... }:
              {
                nixpkgs.overlays = [
                  rust-overlay.overlays.default
                ];
                environment.systemPackages = with pkgs; [
                  rust-bin.stable.latest.default
                ];
              }
            )
          ];
        };
    in
    {
      nixosConfigurations = {
        spaceship = createConfiguration "spaceship";
        framework = createConfiguration "framework";
      };
    };
}
