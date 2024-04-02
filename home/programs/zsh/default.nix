{ config, lib, pkgs, ... }:

{
    programs = {
        zsh = {
            enable = true;
            oh-my-zsh = {
                enable = true;
                theme = "refined";
                plugins = [
                    "git"
                ];
            };

            autosuggestion.enable = true;
            enableCompletion = true;
            syntaxHighlighting.enable = true;

        initExtra = ''
	  neofetch
        '';
        };
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
}
