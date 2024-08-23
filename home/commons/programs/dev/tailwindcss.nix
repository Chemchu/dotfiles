  {
    programs.nixvim = {
      plugins.lsp = {
        enable = true;
        servers = {
          tailwindcss = { enable = true; };
        };
      };
    };
  }
