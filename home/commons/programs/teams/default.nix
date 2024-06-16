{
  inputs,
  ...
}
:
{
  #imports = [ inputs.flatpaks.homeManagerModules.nix-flatpak ];
  #services.flatpak.packages = [
  #  "com.github.IsmaelMartinez.teams_for_linux"
  #];
}
