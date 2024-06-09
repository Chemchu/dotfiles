{
  programs.nixvim = {
    plugins.mini = {
      enable = true;

      modules = {
        ai = { };
        animate = { };
        cursorword = { };
      };
    };
  };
}
