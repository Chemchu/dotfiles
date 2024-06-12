{
  ...
}: {
  programs.nixvim = {
    plugins = {
      lsp.servers = {
        tsserver = {
          enable = true;
          settings = {
            tsserver = {
              format = {
                enable = true;
              };
            };
          };
        };
      };
    };
  };
}
