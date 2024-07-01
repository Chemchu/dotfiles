{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      ocaml
      opam
      ocamlPackages.utop
      dune_3
      ocamlPackages.ocamlformat
    ];
  };

  programs.nixvim = {
    plugins = {
      none-ls.sources.formatting.ocamlformat.enable = true;
      lsp-format.lspServersToEnable = ["ocamllsp"];
      lsp.servers = {
        ocamllsp = {
          enable = true;
        };
      };
    };
  };
}
