{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      playerctl
      gobject-introspection
      # Python
      (python3.withPackages (
        ps:
          with ps; [
            # Misc
            pygobject3
            pygobject-stubs
            pip
            setuptools

            # RL
            matplotlib
            numpy
            requests
            torch
            tensorboard
          ]
      ))

      mypy
    ];

    shellAliases = {
      pyp = "PYTHONPATH=. python";
    };
  };

  programs = {
    ruff = {
      enable = true;

      settings = {
        line-length = 100;

        lint = {
          per-file-ignores = {
            # Ignore `F401` (unused import) in all `__init__.py` files
            "__init__.py" = ["F401"];
          };
        };
      };
    };

    nixvim = {
      filetype.extension.gin = "gin";
      plugins = {
        treesitter.languageRegister.python = ["gin"];
        lsp-format.lspServersToEnable = ["ruff-lsp"];
        lsp.servers = {
          ruff-lsp.enable = true;
          pylsp = {
            enable = false; # --> Cambiar cuando se use python
            settings = {
              plugins = {
                jedi_completion.fuzzy = true;

                pylsp_mypy.enabled = true;

                # We don't need those as ruff-lsp is already providing such features.
                autopep8.enabled = false;
                flake8.enabled = false;
                mccabe.enabled = false;
                preload.enabled = false;
                pycodestyle.enabled = false;
                pydocstyle.enabled = false;
                pyflakes.enabled = false;
                pylint.enabled = false;
                ruff.enabled = false;
                yapf.enabled = false;
              };
            };
          };
        };
      };
    };
  };
}
