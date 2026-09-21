{
  home = {
    file = {
      ".config/fastfetch/logo.txt".source = ./fastfetch_logo.txt;
      ".config/fastfetch/config.jsonc".source = ./config.jsonc;
    };
  };
  programs.fastfetch = {
    enable = true;
  };
}
