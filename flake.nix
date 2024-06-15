{
  description = "My NixOS flake";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; # --> Unstable channel
    nixpkgs.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland"; # --> Last commit
    #hyprland.url = "github:hyprwm/Hyprland?ref=fe7b748";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Widgets
    ags.url = "github:Aylur/ags";
    matugen.url = "github:InioX/matugen?ref=v2.2.0";
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    nix-index-database,
    rust-overlay,
    ...
  } @ inputs:
	{
    packages.x86_64-linux.default =
      nixpkgs.legacyPackages.x86_64-linux.callPackage ./home/hyprland/hyprland-commons/ags/ags-config {inherit inputs;};

		nixosConfigurations = {
		  hyprland = nixpkgs.lib.nixosSystem {
				specialArgs = {
          inherit inputs;
          asztal = self.packages.x86_64-linux.default;
        };
				modules = [
					./nixos/configuration.nix
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
