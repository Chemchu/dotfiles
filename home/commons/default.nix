{
  pkgs,
  ...
}:
{
  imports = [
    ./programs
  ];

  home.packages = with pkgs; [
    spotify
  ];

}
