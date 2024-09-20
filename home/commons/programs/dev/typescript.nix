{
  ...
}: {
  programs.nixvim = {
    plugins.lsp.servers = {
      tailwindcss = { enable = true; };
      ts-ls = {
        enable = true;
        autostart = true;
        filetypes = ["typescript" "typescriptreact" "jsx" "javascript" "javascriptreact" "tsx"];
      };
    };
  };
}
