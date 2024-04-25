{
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    zsh = {
      enable = true;
      initExtra = ''
        export DIRENV_LOG_FORMAT=""
      '';
    };
  };
}
