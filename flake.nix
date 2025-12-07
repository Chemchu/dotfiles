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
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wallpaper = {
      url = "https://raw.githubusercontent.com/D3Ext/aesthetic-wallpapers/main/images/australia.jpg";
      flake = false;
    };
    lock-wallpaper = {
      url = "https://raw.githubusercontent.com/D3Ext/aesthetic-wallpapers/main/images/australia.jpg";
      flake = false;
    };
  };
  outputs = inputs @ {
    home-manager,
    nixpkgs,
    rust-overlay,
    nix-flatpak,
    wallpaper,
    lock-wallpaper,
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
          {
            # Pass wallpaper to home-manager modules
            home-manager.extraSpecialArgs = {
              inherit wallpaper lock-wallpaper;
            };
          }
          nix-flatpak.nixosModules.nix-flatpak
          (
            {pkgs, ...}: {
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
  in {
    nixosConfigurations = {
      framework = createConfiguration "framework";
    };
  };
}
