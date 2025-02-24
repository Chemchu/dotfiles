{pkgs, ...}: {
  imports = [
    ./bun.nix
    ./direnv.nix
    ./java.nix
    ./node.nix
    ./nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];
}
