  {
    programs.nixvim.plugins= {
      friendly-snippets.enable = true;
      lsp = {
        enable = true;
        servers.html = {
          enable = true;
          filetypes = [ "html" ];
        };
      };
    };
  }
