{
  imports = [
    ./barbar.nix
    ./copilot.nix
    ./comment.nix
    ./efm.nix
    ./floaterm.nix
    ./harpoon.nix
    ./leap.nix
    ./lsp.nix
    ./lualine.nix
    ./markdown-preview.nix
    ./mini.nix
    ./neorg.nix
    ./neo-tree.nix
    ./startify.nix
    ./tagbar.nix
    ./telescope.nix
    ./treesitter.nix
    ./vimtex.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    colorschemes.onedark.enable = true;

    plugins = {
      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };

      nvim-autopairs.enable = true;

      nvim-colorizer = {
        enable = true;
        userDefaultOptions.names = false;
      };

      oil.enable = true;

    };
  };
}
