{
  inputs,
  ...
}:
{
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
    };
  };

  # nvf = {
  #   enable = true;
  #   theme = {
  #     enable = true;
  #     name = "onedark";
  #   };
  #   statusline.lualine.enable = true;
  #   telescope.enable = true;
  #   autocomplete.nvim-cmp.enable = true;
  #   languages = {
  #     enableLSP = true;
  #     enableTreesitter = true;
  #     nix.enable = true;
  #     ts.enable = true;
  #     rust.enable = true;
  #   };
  # };
}
