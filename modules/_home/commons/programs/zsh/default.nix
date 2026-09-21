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
      initContent = ''
        fastfetch
      '';
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
