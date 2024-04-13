{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixvim, ... }@inputs:
	let
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in
	{
		nixosConfigurations = {
			nixos = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				modules = [
					./nixos/configuration.nix
					inputs.home-manager.nixosModules.default
					inputs.hyprland.nixosModules.default
				];
			};
		};
	};
}
