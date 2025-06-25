{inputs, ...}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        debugMode = {
          enable = false;
          level = 16;
          logFile = "/tmp/nvim.log";
        };

        spellcheck = {
          enable = false;
        };

        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = true;
          otter-nvim.enable = false;
          nvim-docs-view.enable = false;
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        # This section does not include a comprehensive list of available language modules.
        # To list all available language module options, please visit the nvf manual.
        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          # Languages that will be supported in default and maximal configurations.
          nix.enable = false;
          markdown.enable = true;

          # Languages that are enabled in the maximal configuration.
          bash.enable = true;
          clang.enable = true;
          css.enable = true;
          html.enable = true;
          sql.enable = true;
          ts.enable = true;
          go.enable = true;
          lua.enable = true;
          zig.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
          };

          # Language modules that are not as common.
          assembly.enable = false;
          astro.enable = false;
          nu.enable = false;
          csharp.enable = false;
          julia.enable = false;
          vala.enable = false;
          scala.enable = false;
          r.enable = false;
          gleam.enable = false;
          dart.enable = false;
          ocaml.enable = false;
          elixir.enable = false;
          haskell.enable = false;

          tailwind.enable = false;
          svelte.enable = false;

          # Nim LSP is broken on Darwin and therefore
          # should be disabled by default. Users may still enable
          # `vim.languages.vim` to enable it, this does not restrict
          # that.
          # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>
          nim.enable = false;
        };

        visuals = {
          nvim-scrollbar.enable = false;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = false;
          fidget-nvim.enable = false;

          highlight-undo.enable = true;
          indent-blankline.enable = false;

          # Fun
          cellular-automaton.enable = false;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "onedark";
          };
        };

        theme = {
          enable = true;
          name = "onedark";
          style = "darker";
          transparent = false;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = false;
          };
          nvimTree = {
            enable = true;
            mappings.toggle = "<leader>e";
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false; # throws an annoying debug message
        };

        minimap = {
          minimap-vim.enable = false;
          codewindow.enable = false; # lighter, faster, and uses lua for configuration
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        projects = {
          project-nvim.enable = true;
        };

        utility = {
          ccc.enable = false;
          vim-wakatime.enable = false;
          surround.enable = true;
          diffview-nvim.enable = true;
          motion = {
            hop.enable = false;
            leap.enable = true;
            precognition.enable = false;
          };

          images = {
            image-nvim.enable = false;
          };
        };

        notes = {
          obsidian.enable = false;
          neorg.enable = false;
          orgmode.enable = false;
          mind-nvim.enable = false;
          todo-comments.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = false;
            lazygit.enable = false;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false; # the theme looks terrible with catppuccin
          illuminate.enable = true;
          breadcrumbs = {
            enable = false;
            navbuddy.enable = false;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              # this is a freeform module, it's `buftype = int;` for configuring column position
              nix = "110";
              ruby = "120";
              java = "130";
              go = ["90" "130"];
            };
          };
          fastaction.enable = true;
        };

        assistant = {
          chatgpt.enable = false;
          copilot = {
            enable = false;
          };
        };

        session = {
          nvim-session-manager.enable = false;
        };

        gestures = {
          gesture-nvim.enable = false;
        };

        comments = {
          comment-nvim.enable = true;
        };

        presence = {
          neocord.enable = false;
        };

        keymaps = [
          {
            key = "<leader>bx";
            mode = "n";
            silent = true;
            action = ":bd<CR>";
            desc = "Close buffer";
          }
          {
            key = "<S-h>";
            mode = "n";
            silent = true;
            action = ":bnext<CR>";
            desc = "Next buffer";
          }
          {
            key = "<S-l>";
            mode = "n";
            silent = true;
            action = ":bprevious<CR>";
            desc = "Previous buffer";
          }
          {
            key = "<C-h>";
            mode = "n";
            silent = true;
            action = "<C-w>h";
            desc = "Move to the left window";
          }
          {
            key = "<C-l>";
            mode = "n";
            silent = true;
            action = "<C-w>l";
            desc = "Move to the right window";
          }
          {
            key = "<Esc>";
            mode = "n";
            silent = true;
            action = ":nohlsearch<CR>";
            desc = "Clear search result";
          }
          {
            key = "<leader>xx";
            mode = "n";
            silent = true;
            action = "<cmd>Trouble diagnostics toggle<cr>";
            desc = "Toggle diagnostics";
          }
          {
            key = "<leader>xX";
            mode = "n";
            silent = true;
            action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
            desc = "Toggle buffer diagnostics";
          }
          {
            key = "J";
            mode = "n";
            silent = true;
            action = ":lua vim.diagnostic.open_float()<CR>";
            desc = "Toggle inline diagnostics";
          }
          {
            key = "gd";
            mode = "n";
            silent = true;
            action = ":lua vim.lsp.buf.definition()<CR>";
            desc = "Go to definition";
          }
          {
            key = "gD";
            mode = "n";
            silent = true;
            action = ":lua vim.lsp.buf.declaration()<CR>";
            desc = "Go to declaration";
          }
          {
            key = "s";
            mode = "n";
            silent = true;
            action = ":lua require('leap').leap { target_windows = { vim.fn.win_getid() } }<CR>";
            desc = "Leap in buffer";
          }
        ];
      };
    };
  };
}
