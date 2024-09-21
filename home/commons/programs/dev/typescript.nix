{
  programs.nixvim = {
    plugins = {
      lsp-format.lspServersToEnable = ["ts-ls"];
      lsp.servers = {
        tailwindcss = { enable = true; };
        ts-ls = {
          enable = true;
          autostart = true;
          filetypes = ["typescript" "typescriptreact" "jsx" "javascript" "javascriptreact" "tsx"];
        };
      };
    };
  };
}
