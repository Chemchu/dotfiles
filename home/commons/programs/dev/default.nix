{pkgs, ...}: {
  imports = [
    ./apptainer.nix
    ./direnv.nix
    ./java.nix
    ./node.nix
    ./nix
    ./python.nix
    ./rust.nix
    ./shell.nix
/*     ./vulkan.nix */
    ./typst.nix
  ];

  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];
}
