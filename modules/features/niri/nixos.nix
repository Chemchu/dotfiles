{self, ...}: {
  flake.nixosModules.niri = {pkgs, ...}: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
    environment.etc."niri-config.kdl".source = "${self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri}/niri-config.kdl";
    environment.etc."niri-cheatsheet.kdl".source = "${self.packages.${pkgs.stdenv.hostPlatform.system}.niri-cheatsheet}";
  };
}
