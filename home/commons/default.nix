{
  pkgs,
  ...
}:
{
  imports = [
    ./programs
  ];

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    cmake
    spotify
    jq
  ];

}
