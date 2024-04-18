{ ... }:
{
    programs = {
        zsh = {
            enable = true;
            oh-my-zsh = {
                enable = true;
                theme = "gnzh";
                plugins = [
                    "git"
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
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
}
