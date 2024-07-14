  {
    programs.nixvim = {
      plugins.lsp = {
        enable = true;
        servers.html = {
          enable = true;
          filetypes = [ "html" "test" ];
        };
      };
    };
  }
