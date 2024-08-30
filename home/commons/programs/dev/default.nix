{pkgs, ...}: {
  imports = [
    ./apptainer.nix
    ./bun.nix
    ./direnv.nix
    ./java.nix
    ./node.nix
    ./nix
    ./ocaml.nix
/*     ./python.nix */
    ./rust.nix
    ./shell.nix
    ./html.nix
    ./htmx.nix
/*     ./vulkan.nix */
    ./tailwindcss.nix
    ./typescript.nix
/*     ./typst.nix */
    ./zig.nix
  ];

  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];
}
