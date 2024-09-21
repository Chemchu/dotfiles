{
  pkgs,
  ...
} :
{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
            "<leader>cr" = "rename";
            "<leader>ca" = "code_action";
          };
        };

        servers = {
          clangd.enable = true;
          lua-ls.enable = true;
          texlab.enable = true;
        };
      };
      efmls-configs = {
        enable = true;

        toolPackages.mdformat = pkgs.mdformat.withPlugins (
          ps: with ps; [
            # TODO: broken with update of mdformat
            # mdformat-gfm
            mdformat-frontmatter
            mdformat-footnote
            mdformat-tables
            mdit-py-plugins
          ]
        );

        externallyManagedPackages = ["deno_fmt"];

        setup = {
          sh = {
            #linter = "shellcheck";
            formatter = "shfmt";
          };
          bash = {
            #linter = "shellcheck";
            formatter = "shfmt";
          };
          c = {
            linter = "cppcheck";
          };
          markdown = {
            formatter = [
              "cbfmt"
              "mdformat"
            ];
          };
          python = {
            formatter = "black";
          };
          nix = {
            linter = "statix";
          };
          lua = {
            formatter = "stylua";
          };
          html = {
            formatter = [
              "prettier"
            ];
            linter = "djlint";
          };
          htmldjango = {
            linter = "djlint";
          };
          json = {
            formatter = "prettier";
          };
          css = {
            formatter = "prettier";
          };
          typescript = {
            formatter = "prettier";
            linter = [
              "eslint"
              "eslint_d"
            ];
          };
          typescriptreact = {
            formatter = "deno_fmt";
            linter = [
              "alex"
              "codespell"
            ];
          };
          gitcommit = {
            linter = "gitlint";
          };
        };
      };
    };
  };
}
