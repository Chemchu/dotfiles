{
  description = "Gus NixOs cool configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs"; # --> Stable channel
    #nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable-small";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #hyprland = {
    #  url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=refs/tags/v0.41.2";
    #};

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1";

    nixvim = {
      url = "github:nix-community/nixvim"; # --> Stable channel
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
    matugen = {
      url = "github:InioX/matugen?ref=v2.2.0";
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
      hyprland = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
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
