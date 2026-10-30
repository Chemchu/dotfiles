{...}: {
  perSystem = {pkgs, ...}: let
    # Noctalia v5 reads every *.toml in $NOCTALIA_CONFIG_HOME/noctalia/.
    # GUI changes go to ~/.local/state/noctalia/settings.toml, layered on top.
    configHome = pkgs.writeTextDir "noctalia/settings.toml" (builtins.readFile ./settings.toml);
  in {
    packages.myNoctalia = pkgs.symlinkJoin {
      name = "noctalia-${pkgs.noctalia.version}";
      paths = [pkgs.noctalia];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        rm $out/bin/noctalia
        makeWrapper ${pkgs.noctalia}/bin/noctalia $out/bin/noctalia \
          --set NOCTALIA_CONFIG_HOME ${configHome}
      '';
      meta.mainProgram = "noctalia";
    };
  };
}
