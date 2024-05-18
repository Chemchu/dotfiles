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
    shaderc
    cmake
    gnumake
    spotify
    jq
  ];

}
