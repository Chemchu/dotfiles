{pkgs, ...}: {
  imports = [
    ./apptainer.nix
    ./bun.nix
    ./direnv.nix
    ./java.nix
    ./node.nix
    ./nix
    ./python.nix
    ./rust.nix
    ./shell.nix
    ./htmx.nix
/*     ./vulkan.nix */
    ./typescript.nix
    ./typst.nix
  ];

  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];
}
