{pkgs, ...}: {
  imports = [
    ./apptainer.nix
    ./direnv.nix
    ./java.nix
    ./nix
    ./python.nix
    ./rust.nix
    ./shell.nix
    ./typst.nix
  ];

  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];
}
