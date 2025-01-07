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
      vim = {
        viAlias = true;
        vimAlias = true;
        theme = {
          enable = true;
          name = "onedark";
        };
        statusline.lualine.enable = true;
        tabline.nvimBufferline.enable = true;
        autopairs.nvim-autopairs.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        utility.motion.hop.enable = true;
        ui.colorizer.enable = true;
        comments.comment-nvim.enable = true;
        debugger.nvim-dap.enable = true;
        utility.preview.glow.enable = true;
        lsp.trouble.enable = true;
        filetree.neo-tree.enable = true;
        terminal.toggleterm.enable = true;

        languages = {
          markdown.enable = true;
          enableLSP = true;
          enableTreesitter = true;
          nix.enable = true;
          ts.enable = true;
          rust.enable = true;
        };

        binds.whichKey = {
          enable = true;
        };

        keymaps = [
          {
            key = "<Space>";
            mode = ["n" "v" "c"];
            silent = true;
            action = "<NOP>";
          }
          {
            key = "<leader>s";
            mode = "n";
            silent = true;
            action = ":w<CR>";
            desc = "Save buffer";
          }
        ];
      };
    };
  };
}
