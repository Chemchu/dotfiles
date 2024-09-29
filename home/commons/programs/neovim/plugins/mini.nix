{
  programs.nixvim = {
    plugins.mini = {
      modules.icons.enable = true;
      mockDevIcons = true;
      enable = true;

      modules = {
        ai = { };
        cursorword = { };
      };
    };
  };
}
