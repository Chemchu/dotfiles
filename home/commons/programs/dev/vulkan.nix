{
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      shaderc
      cmake
      gnumake
    ];
  };
}
