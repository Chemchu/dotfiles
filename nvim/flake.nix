{
  description = "Gus neovim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nvf,
    ...
  }: let
    systems = ["x86_64-linux" "aarch64-linux"];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    packages = forAllSystems (system: {
      default = (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [./config.nix ./debugger.nix];
      }).neovim;
    });

    apps = forAllSystems (system: {
      default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/nvim";
      };
    });

    # Import this in your home-manager config to embed the same configuration.
    # The nvf home-manager module is bundled here so you don't need a separate nvf input.
    homeManagerModules.default = {
      imports = [nvf.homeManagerModules.default];
      programs.nvf = {
        enable = true;
        enableManpages = true;
        settings.imports = [
          (self + "/config.nix")
          (self + "/debugger.nix")
        ];
      };
    };
  };
}
