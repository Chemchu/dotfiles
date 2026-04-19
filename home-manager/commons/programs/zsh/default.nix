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
          echo "1) Hyprland"
          echo "2) Niri"
          read "choice?> "
          case $choice in
            1) exec start-hyprland ;;
            2) exec niri-session ;;
          esac
        fi
      '';
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
