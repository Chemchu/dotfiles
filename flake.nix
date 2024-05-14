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

    rust-overlay.url = "github:oxalica/rust-overlay";

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self,
    nixpkgs,
    nixvim,
    nix-index-database,
    rust-overlay,
    ...
  } @ inputs:
	{
		nixosConfigurations = {
			hyprland-personal = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				modules = [
					./nixos/hyprland-personal-configuration.nix
					inputs.home-manager.nixosModules.default
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
          })
				];
			};
			hyprland-work = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				modules = [
					./nixos/hyprland-work-configuration.nix
					inputs.home-manager.nixosModules.default
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
          })
				];
			};
			gnome-work = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				modules = [
					./nixos/gnome-work-configuration.nix
					inputs.home-manager.nixosModules.default
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            environment.systemPackages = [ pkgs.rust-bin.stable.latest.default ];
          })
				];
			};
		};
	};
}
