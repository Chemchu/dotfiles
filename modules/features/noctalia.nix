{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.myNoctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs; # THIS PART IS VERY IMPORTAINT, I FORGOT IT IN THE VIDEO!!!
      inherit
        ((builtins.fromJSON
          (builtins.readFile ./noctalia.json)))
        settings
        ;
    };
  };
}
