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
      wl-clipboard
      prettierd
      typescript-language-server
      rust-analyzer
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/plugin/lsp.lua;
      }

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      {
        plugin = onedarkpro-nvim;
        config = "colorscheme onedark";
      }

      neodev-nvim

      nvim-cmp
      {
        plugin = nvim-cmp;
        config = toLuaFile ./nvim/plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/plugin/telescope.lua;
      }

      telescope-fzf-native-nvim
      which-key-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets

      lualine-nvim
      nvim-web-devicons

      {
        plugin = nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
          p.tree-sitter-typescript
          p.tree-sitter-javascript
          p.tree-sitter-go
          p.tree-sitter-html
          p.tree-sitter-css
          p.tree-sitter-scss
          p.tree-sitter-jinja
          p.tree-sitter-sql
          p.tree-sitter-hyprlang
          p.tree-sitter-xml
          p.tree-sitter-c
          p.tree-sitter-markdown
          p.tree-sitter-tsx
          p.tree-sitter-regex
          p.tree-sitter-toml
          p.tree-sitter-yaml
        ]);
        config = toLuaFile ./nvim/plugin/treesitter.lua;
      }

      vim-nix
      neo-tree-nvim
      yanky-nvim
      trouble-nvim
      {
        plugin = conform-nvim;
        config = toLuaFile ./nvim/plugin/conform.lua;
      }
      lualine-nvim
      bufferline-nvim
      mini-icons
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
      ${builtins.readFile ./nvim/keymaps.lua}
    '';
  };
}
