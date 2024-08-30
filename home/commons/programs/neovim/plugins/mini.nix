{
  programs.nixvim = {
    plugins.mini = {
      enable = true;

      modules = {
        ai = { };
        cursorword = { };
      };
    };
  };
}
