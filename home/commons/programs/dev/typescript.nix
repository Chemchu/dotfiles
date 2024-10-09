{
  programs.nixvim = {
    plugins = {
      lsp-format.lspServersToEnable = ["ts_ls"];
      lsp.servers = {
        tailwindcss = { enable = true; };
        ts_ls = {
          enable = true;
          autostart = true;
          filetypes = ["typescript" "typescriptreact" "jsx" "javascript" "javascriptreact" "tsx"];
        };
      };
    };
  };
}
