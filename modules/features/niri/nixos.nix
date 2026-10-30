{self, ...}: {
  flake.nixosModules.niri = {pkgs, ...}: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
    environment.systemPackages = [self.packages.${pkgs.stdenv.hostPlatform.system}.myNoctalia];
    environment.etc."niri-config.kdl".source = "${self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri}/niri-config.kdl";
  };
}
