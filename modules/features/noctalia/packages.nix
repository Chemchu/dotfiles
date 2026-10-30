{...}: {
  perSystem = {pkgs, ...}: let
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
