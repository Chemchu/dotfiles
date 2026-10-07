{
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    zsh = {
      enable = true;
      initContent = ''
        export DIRENV_LOG_FORMAT=""
        ZSH_AUTOSUGGEST_HISTORY_IGNORE="claude *"
        HISTORY_IGNORE="(claude|claude *)"
      '';
    };
  };
}
