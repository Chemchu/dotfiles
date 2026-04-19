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

        if [[ -z "$WAYLAND_DISPLAY" && -z "$DISPLAY" && "$(tty)" == "/dev/tty1" ]]; then
          read "choice?Start niri? [Y/n] "
          if [[ "$choice" != "n" && "$choice" != "N" ]]; then
            exec niri-session
          fi
        fi
      '';
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
