{pkgs, ...}: {
  imports = [];

  home.packages = with pkgs; [
    everforest-cursors
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "everforest-cursors";
    XCURSOR_SIZE = "26";
  };
}
