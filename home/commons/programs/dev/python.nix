{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      playerctl
      gobject-introspection
      # Python
      (python3.withPackages (
        ps: with ps; [
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
            "__init__.py" = [ "F401" ];
          };
        };
      };
    };
  };
}
