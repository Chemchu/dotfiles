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
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=refs/tags/v0.41.1";
    };
    hyprwayland-scanner = {
      url = "github:hyprwm/hyprwayland-scanner";
    };
    #nixvim = {
    #  #url = "github:nix-community/nixvim?ref=ad6a08b"; # --> Only for unstable channel
    #  #url = "github:nix-community/nixvim/nixos-24.05"; # --> Only for stable channel
    #  url = "github:nix-community/nixvim";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
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
    ags = {
      url = "github:Aylur/ags";
    };
    matugen = {
      url = "github:InioX/matugen?ref=v2.2.0";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-index-database,
    rust-overlay,
    home-manager,
    hyprwayland-scanner,
    ...
  }: let
    system = "x86_64-linux";
  in {
    packages.${system}.default = nixpkgs.legacyPackages.${system}.callPackage ./home/hyprland/hyprland-commons/ags/ags-config { inherit inputs; };

    nixosConfigurations = {
      hyprland = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          asztal = self.packages.${system}.default;
        };
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.default
          ({ pkgs, ... }: {
            nixpkgs.overlays = [
              rust-overlay.overlays.default
            ];
            environment.systemPackages = with pkgs; [
              rust-bin.stable.latest.default
              #hyprwayland-scanner.packages.${system}.hyprwayland-scanner
            ];
          })
        ];
      };
    };
  };
}
