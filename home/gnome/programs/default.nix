{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    teams-for-linux
    postman
    dbeaver-bin
  ];
}

