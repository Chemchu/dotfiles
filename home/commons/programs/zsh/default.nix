{
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
          enable = true;
          theme = "gnzh";
          plugins = [
              "git"
              "direnv"
          ];
      };
      autosuggestion.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        neofetch
        fortune
      '';
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
