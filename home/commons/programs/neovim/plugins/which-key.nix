{
  programs.nixvim = {
    plugins.which-key= {
      enable = true;
      settings.spec = [
        {
          __unkeyed-1 = "<leader>s";
          desc = "Save";
        }
        {
          __unkeyed-1 = "<leader>f";
          desc = "Find";
          group = "Telescope";
        }
        {
          __unkeyed-1 = "<leader>ff";
          desc = "Find files";
          group = "Telescope";
        }
        {
          __unkeyed-1 = "<leader><space>";
          desc = "Find files";
          group = "Telescope";
        }
        {
          __unkeyed-1 = "<leader>fg";
          desc = "Find (live) grep";
          group = "Telescope";
        }
        {
          __unkeyed-1 = "<leader>b";
          desc = "Show buffers";
          group = "Telescope";
        }
        {
          __unkeyed-1 = "<leader>fh";
          desc = "Help tags";
          group = "Telescope";
        }
        {
          __unkeyed-1 = "<leader>fd";
          desc = "Show diagnostics";
          group = "Telescope";
        }
        {
          __unkeyed-1 = "<C-p>";
          desc = "Git files";
          group = "FZF like bindings";
        }
        {
          __unkeyed-1 = "<leader>p";
          desc = "Find oldfiles";
          group = "FZF like bindings";
        }
        {
          __unkeyed-1 = "<C-f>";
          desc = "Find (live) grep";
          group = "FZF like bindings";
        }
        {
          __unkeyed-1 = "<C-b>";
          desc = "Toggle line";
          group = "Comment";
        }
        {
          __unkeyed-1 = "<leader>,";
          desc = "Toggle Floaterm";
          group = "Floaterm";
        }
        {
          __unkeyed-1 = "<leader>k";
          desc = "Go to prev diagnostics";
          group = "LSP - Diagnostics";
        }
        {
          __unkeyed-1 = "<leader>j";
          desc = "Go to next diagnostics";
          group = "LSP - Diagnostics";
        }
        {
          __unkeyed-1 = "gd";
          desc = "Go to definition";
          group = "LSP - Diagnostics";
        }
        {
          __unkeyed-1 = "gD";
          desc = "Go to references";
          group = "LSP - Diagnostics";
        }
        {
          __unkeyed-1 = "gt";
          desc = "Type definition";
          group = "LSP - Diagnostics";
        }
        {
          __unkeyed-1 = "gi";
          desc = "Go to implementation";
          group = "LSP - Diagnostics";
        }
        {
          __unkeyed-1 = "K";
          desc = "Hover (details)";
          group = "LSP - Diagnostics";
        }
        {
          __unkeyed-1 = "<F2>";
          desc = "Rename";
          group = "LSP - Diagnostics";
        }
        {
          __unkeyed-1 = "<leader>cr";
          desc = "Rename";
          group = "LSP - Diagnostics";
        }
        {
          __unkeyed-1 = "<leader>ca";
          desc = "Code Action";
          group = "LSP - Diagnostics";
        }
        {
          __unkeyed-1 = "<leader>m";
          desc = "Markdown preview";
          group = "Markdown";
        }
        {
          __unkeyed-1 = "<leader>e";
          desc = "Toggle NeoTree";
          group = "Neotree";
        }
        {
          __unkeyed-1 = "<C-g>";
          desc = "(Neo)rganizar?";
          group = "Neorg";
        }
        {
          __unkeyed-1 = "mm";
          desc = "VimTex view";
          group = "Vimtex";
        }
      ];
    };
  };
}

