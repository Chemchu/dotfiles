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
        }
        {
          __unkeyed-1 = "<leader>ff";
          desc = "Find files";
        }
        {
          __unkeyed-1 = "<leader><space>";
          desc = "Find files";
        }
        {
          __unkeyed-1 = "<leader>fg";
          desc = "Find (live) grep";
        }
        {
          __unkeyed-1 = "<leader>b";
          desc = "Show buffers";
        }
        {
          __unkeyed-1 = "<leader>fh";
          desc = "Help tags";
        }
        {
          __unkeyed-1 = "<leader>fd";
          desc = "Show diagnostics";
        }
        {
          __unkeyed-1 = "<C-p>";
          desc = "Git files";
        }
        {
          __unkeyed-1 = "<leader>p";
          desc = "Find oldfiles";
        }
        {
          __unkeyed-1 = "<C-f>";
          desc = "Find (live) grep";
        }
        {
          __unkeyed-1 = "<C-b>";
          desc = "Toggle line";
        }
        {
          __unkeyed-1 = "<leader>,";
          desc = "Toggle Floaterm";
        }
        {
          __unkeyed-1 = "<leader>k";
          desc = "Go to prev diagnostics";
        }
        {
          __unkeyed-1 = "<leader>j";
          desc = "Go to next diagnostics";
        }
        {
          __unkeyed-1 = "gd";
          desc = "Go to definition";
        }
        {
          __unkeyed-1 = "gD";
          desc = "Go to references";
        }
        {
          __unkeyed-1 = "gt";
          desc = "Type definition";
        }
        {
          __unkeyed-1 = "gi";
          desc = "Go to implementation";
        }
        {
          __unkeyed-1 = "K";
          desc = "Hover (details)";
        }
        {
          __unkeyed-1 = "<F2>";
          desc = "Rename";
        }
        {
          __unkeyed-1 = "<leader>cr";
          desc = "Rename";
        }
        {
          __unkeyed-1 = "<leader>ca";
          desc = "Code Action";
        }
        {
          __unkeyed-1 = "<leader>m";
          desc = "Markdown preview";
        }
        {
          __unkeyed-1 = "<leader>e";
          desc = "Toggle NeoTree";
        }
        {
          __unkeyed-1 = "<C-g>";
          desc = "(Neo)rganizar?";
        }
        {
          __unkeyed-1 = "mm";
          desc = "VimTex view";
        }
      ];
    };
  };
}

