{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      alejandra
      nix-init
      nix-tree
      nix-output-monitor
      statix

      # nixpkgs
      nix-update
      nixpkgs-review
      luarocks-packages-updater
      vimPluginsUpdater
      (pkgs.writeShellApplication {
        name = "nixpkgs-review-tmux";
        text = builtins.readFile ./review.sh;
        runtimeInputs = with pkgs; [
          nixpkgs-review
          tmux
        ];
      })
    ];

    shellAliases = {
      nb = "nom-build --system x86_64-linux -A";
      nba = "nom-build --system aarch64-linux -A";
      nbd = "nom-build --system x86_64-darwin -A";
      nbda = "nom-build --system aarch64-darwin -A";
      ur = "unlink result";

      nr = "nixpkgs-review pr --post-result --no-shell";
      nra = "nixpkgs-review pr --post-result --no-shell --system aarch64-linux";
      nrd = "nixpkgs-review pr --post-result --no-shell --system x86_64-darwin";
      nrda = "nixpkgs-review pr --post-result --no-shell --system aarch64-darwin";

      nrt = "nixpkgs-review-tmux";

      nu = "nix-update";
      nuc = "nix-update --commit";
      nucb = "nix-update --commit --build";
    };

    sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
  };
}
