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
      url = "https://cdna.artstation.com/p/assets/images/images/026/931/228/large/pei-fang-asset.jpg?1590118592";
      flake = false;
    };
    lock-wallpaper = {
      url = "https://cdna.artstation.com/p/assets/images/images/026/931/228/large/pei-fang-asset.jpg?1590118592";
      flake = false;
    };
    yt-x = {
      url = "github:Benexl/yt-x";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs @ {
    home-manager,
    nixpkgs,
    rust-overlay,
    nix-flatpak,
    wallpaper,
    lock-wallpaper,
    yt-x,
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
            home-manager = {
              extraSpecialArgs = {
                inherit wallpaper lock-wallpaper;
                wallpapers = [
                  (builtins.fetchurl {
                    url = "https://cdna.artstation.com/p/assets/images/images/026/931/228/large/pei-fang-asset.jpg?1590118592";
                    sha256 = "1pkm4i16sjn3wjr2d0jpnk266gd67bwymrjb5515p6b8j4jraj5g";
                  })
                  (builtins.fetchurl {
                    url = "https://raw.githubusercontent.com/dharmx/walls/refs/heads/main/anime/a_door_with_a_doorway_and_shoes_on_the_ground.jpg";
                    sha256 = "18zfqax82kvhbi3n5xp9ab9yq64akqhqgbhn3lj7ac4gq113lcva";
                  })

                  (builtins.fetchurl {
                    url = "https://raw.githubusercontent.com/dharmx/walls/refs/heads/main/anime/a_beach_with_a_bridge_and_trees.jpg";
                    sha256 = "1v3kwvqfwxlpsm7kw4c5h08frkx748lkzai5dx7sn1y95w2hc4r6";
                  })
                  (builtins.fetchurl {
                    url = "https://raw.githubusercontent.com/dharmx/walls/refs/heads/main/anime/a_cartoon_of_a_girl_and_a_dog.png";
                    sha256 = "0yw4maiv9w2wdikg87ky2d04yr1qc8qa5ifv9ckcqy0hn6y5chhi";
                  })
                  (builtins.fetchurl {
                    url = "https://raw.githubusercontent.com/dharmx/walls/refs/heads/main/anime/power_lines_and_trees_at_sunset.jpg";
                    sha256 = "0fdw2f0z12435bb18lcq2vfnf9qlzz4wyj40r5yblslc8z7xj7ch";
                  })
                ];
              };
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
                yt-x.packages.${pkgs.system}.default
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
