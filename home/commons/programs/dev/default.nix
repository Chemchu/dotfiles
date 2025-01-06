{ pkgs, ... }:
{
  imports = [
    ./bun.nix
    ./direnv.nix
    ./node.nix
    ./nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];
}
