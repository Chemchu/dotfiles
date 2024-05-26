  {
    programs.nixvim = {
      plugins.lsp = {
        enable = true;
        servers = {
          htmx = { enable = true; };
        };
      };
    };
  }
