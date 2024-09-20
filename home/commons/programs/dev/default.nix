{pkgs, ...}: {
  imports = [
    ./apptainer.nix
    ./bun.nix
    ./direnv.nix
    ./java.nix
    ./node.nix
    ./nix
    ./ocaml.nix
    ./rust.nix
    ./shell.nix
    ./html.nix
    ./htmx.nix
    ./typescript.nix
    ./zig.nix
  ];

  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];
}
