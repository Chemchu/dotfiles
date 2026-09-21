{...}: {
  # Plain home-manager module tree, kept underscore-prefixed so import-tree
  # doesn't try to import its files directly as flake-parts modules.
  flake.homeModules.gus = import ./_home/default.nix;
}
