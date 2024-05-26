  {
    programs.nixvim = {
      lsp = {
        enable = true;
        servers = {
          htmx = { enable = true; };
        };
      };
    };
  }
