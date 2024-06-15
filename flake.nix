{
  description = "Gus NixOs cool configuration";

  outputs = inputs @ {
    self,
    nixpkgs,
    nixvim,
    nix-index-database,
    rust-overlay,
    home-manager,
    ...
  }: {
    packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.callPackage ./home/hyprland/hyprland-commons/ags/ags-config {inherit inputs;};

		nixosConfigurations = {
		  hyprland = nixpkgs.lib.nixosSystem {
				specialArgs = {
          inherit inputs;
          asztal = self.packages.x86_64-linux.default;
        };
				modules = [
					./nixos/configuration.nix
					home-manager.nixosModules.default
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            environment.systemPackages = [
              pkgs.rust-bin.stable.latest.default
            ];
          })
				];
			};
		};
	};

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

    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?tag=v0.40.0&submodules=1"; # --> Probando comentario que vi en discord
    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=refs/tags/v0.41.1"; # --> Probando comentario que vi en discord
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    #hyprland.url = "github:hyprwm/Hyprland"; # --> Last commit
    #hyprland.url = "github:hyprwm/Hyprland?ref=fe7b748";

    #hyprwayland-scanner.url = "github:hyprwm/hyprwayland-scanner";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lf-icons = {
      url = "github:gokcehan/lf";
      flake = false;
    };

    # Widgets
    ags.url = "github:Aylur/ags";
    matugen.url = "github:InioX/matugen?ref=v2.2.0";
  };
}
