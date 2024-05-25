{
  programs.nixvim = {
    plugins.which-key= {
      enable = true;
      registrations = {
        #Save
        "<leader>s" = "Save";

        # Telescope
        "<leader>f" = "Find";
        "<leader>ff" = "Find files";
        "<leader><space>" = "Find files";
        "<leader>fg" = "Find (live) grep";
        "<leader>b" = "Show buffers";
        "<leader>fh" = "Help tags";
        "<leader>fd" = "Show diagnostics";

        ## FZF like bindings
        "<C-p>" = "Git files";
        "<leader>p" = "Find oldfiles";
        "<C-f>" = "Find (live) grep";

        # Comment
        "<C-b>" = "Toggle line";

        #Floaterm
        "<leader>," = "Toggle Floaterm";

        # LSP - Diagnostics
        "<leader>k" = "Go to prev diagnostics";
        "<leader>j" = "Go to next diagnostics";
        # LSP
        "gd" = "Go to definition";
        "gD" = "Go to references";
        "gt" = "Type definition";
        "gi" = "Go to implementation";
        "K" = "Hover (details)";
        "<F2>" = "Rename";
        "<leader>cr" = "Rename";
        "<leader>ca" = "Code Action";

        # Markdown
        "<leader>m" = "Markdown preview";

        # Neotree
        "<leader>e" = "Toggle NeoTree";

        # Neorg
        "<C-g>" = "(Neo)rganizar?";

       # Vimtex
       "mm" = "VimTex view";
      };
    };
  };
}

