{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      ocaml
      opam
      ocamlPackages.utop
      dune_3
    ];
  };

  programs.nixvim = {
    plugins = {
      crates-nvim.enable = true;
      lsp-format.lspServersToEnable = ["ocamllsp"];
      lsp.servers = {
        ocamllsp = {
          enable = true;
        };
      };
    };
  };
}
