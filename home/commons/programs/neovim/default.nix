{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
      lua-language-server
      nil # Nix LSP
      wl-clipboard
      prettierd
      typescript-language-server
      rust-analyzer
      vscode-extensions.vadimcn.vscode-lldb
    ];
    plugins = with pkgs.vimPlugins; [
      bufferline-nvim
      
      # File explorer
      nvim-tree-lua
      
      # Fuzzy finder
      telescope-nvim
      telescope-fzf-native-nvim
      
      # Syntax highlighting and parsing
      nvim-treesitter.withAllGrammars
      
      # LSP support
      nvim-lspconfig
      
      # Autocompletion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      luasnip
      cmp_luasnip
      
      # Status line
      lualine-nvim
      
      # Git integration
      gitsigns-nvim
      
      # Color scheme
      onedarkpro-nvim
      
      # Icons
      nvim-web-devicons
      
      # Autopairs
      nvim-autopairs
      
      # Comment toggling
      comment-nvim
      
      # Indentation guides
      indent-blankline-nvim
      
      # Which-key for keybindings help
      which-key-nvim
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/plugin/bufferline.lua}
      ${builtins.readFile ./nvim/plugin/lsp.lua}
      ${builtins.readFile ./nvim/plugin/cmp.lua}
      ${builtins.readFile ./nvim/plugin/conform.lua}
      ${builtins.readFile ./nvim/plugin/lualine.lua}
      ${builtins.readFile ./nvim/plugin/other.lua}
      ${builtins.readFile ./nvim/plugin/telescope.lua}
      ${builtins.readFile ./nvim/plugin/treesitter.lua}
      ${builtins.readFile ./nvim/plugin/trouble.lua}
      ${builtins.readFile ./nvim/options.lua}
      ${builtins.readFile ./nvim/keymaps.lua}
    '';
  };
}
