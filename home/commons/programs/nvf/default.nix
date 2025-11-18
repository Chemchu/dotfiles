{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];
  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings = {
      vim = {
        formatter.conform-nvim = {
          enable = true;
          setupOpts.formatters_by_ft = {
            javascript = [
              "prettier"
            ];
            html = [
              "prettier"
            ];
          };
        };
        repl = {
          conjure.enable = false;
        };
        spellcheck = {
          enable = false;
          languages = [
            "en"
            "es"
          ];
        };
        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers.wl-copy.enable = true;
        };
        options = {
          shiftwidth = 2;
          conceallevel = 1;
          scrolloff = 1;
        };
        preventJunkFiles = true;
        searchCase = "smart";
        viAlias = true;
        vimAlias = true;
        undoFile = {
          enable = true;
        };
        debugMode = {
          enable = false;
          level = 16;
          logFile = "/tmp/nvim.log";
        };
        lsp = {
          enable = true;
          formatOnSave = true;
          lspkind.enable = false;
          lightbulb.enable = false;
          lspsaga.enable = false;
          otter-nvim = {
            enable = true;
            setupOpts.buffers.write_to_disk = true;
          };
          trouble.enable = true;
          lspSignature.enable = false; # doesn't work with blink
          nvim-docs-view.enable = false; # lags *horribly* whenever l is pressed
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;
          nim.enable = true;
          nix.enable = true;
          markdown.enable = true;
          html = {
            enable = true;
          };
          css = {
            enable = true;
            format.enable = true;
          };
          r = {
            enable = true;
            format.type = "styler";
          };
          sql.enable = true;
          haskell.enable = true;
          java.enable = false;
          ts = {
            enable = true;
            format.enable = true;
            extraDiagnostics.enable = false;
          };
          svelte.enable = false;
          vala.enable = true;
          go.enable = true;
          elixir.enable = false;
          zig.enable = true;
          ocaml.enable = true;
          nu.enable = true;
          python = {
            enable = true;
            lsp.server = "pyright";
          };
          dart.enable = false;
          lua.enable = true;
          bash.enable = true;
          tailwind.enable = true;
          typst.enable = true;
          julia.enable = false;
          clang = {
            enable = true;
            lsp.server = "clangd";
          };

          rust = {
            enable = true;
            crates.enable = true;
            dap.enable = true;
          };
        };

        visuals = {
          nvim-web-devicons.enable = true;
          cellular-automaton.enable = false;
          fidget-nvim.enable = true;
          highlight-undo.enable = true;

          indent-blankline = {
            enable = true;
          };

          nvim-cursorline = {
            enable = true;
            setupOpts = {
              lineTimeout = 0;
            };
          };
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "onedark";
          };
        };

        # luaConfigRC.basic = ''
        #   vim.g.nvim_ghost_use_script = 1
        #   vim.g.nvim_ghost_python_executable = '${ghosttext-dependencies}/bin/python'
        # '';

        theme = {
          enable = true;
          name = "onedark";
          style = "darker";
          transparent = false;
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete.blink-cmp = {
          enable = true;
          friendly-snippets.enable = true;
          setupOpts = {
            signature.enabled = true;
            cmdline = {
              keymap.preset = "cmdline";
              completion.menu.auto_show = true;
            };
          };
        };
        snippets.luasnip.enable = true;

        filetree = {
          nvimTree = {
            enable = false;
          };
        };

        tabline = {
          nvimBufferline.enable = false;
        };

        treesitter = {
          context.enable = false;
          grammars = [
            pkgs.vimPlugins.nvim-treesitter-parsers.nu
            pkgs.vimPlugins.nvim-treesitter-parsers.kdl
            pkgs.vimPlugins.nvim-treesitter-parsers.rnoweb
            pkgs.vimPlugins.nvim-treesitter-parsers.yaml
            pkgs.vimPlugins.nvim-treesitter-parsers.markdown
            pkgs.vimPlugins.nvim-treesitter-parsers.r
          ];
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          vim-fugitive.enable = true;
          gitsigns = {
            enable = true;
            codeActions.enable = false; # throws an annoying debug message
          };
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
          project-nvim.enable = false;
        };

        utility = {
          undotree.enable = true;
          oil-nvim.enable = true;
          ccc.enable = false;
          vim-wakatime.enable = false;
          icon-picker.enable = true;
          surround.enable = true;
          diffview-nvim.enable = true;
          motion = {
            hop.enable = false;
            leap = {
              enable = true;
              mappings = {
                leapForwardTo = "s";
                leapBackwardTo = "S";
              };
            };
            precognition.enable = false;
          };

          images = {
            image-nvim.enable = false;
            img-clip.enable = true;
          };
        };

        notes = {
          obsidian = {
            enable = false;
            setupOpts = {
              workspaces = [
                {
                  name = "notes";
                  path = "~/Documents/Nextcloud/Notes/markdown";
                }
              ];
              templates = {
                folder = "templates";
                date_format = "%Y-%m-%d-%a";
                time_format = "%H:%M";
              };
            };
          };
          neorg = {
            enable = false;
            setupOpts = {
              load = {
                "core.defaults" = {};
                "core.concealer" = {};
                "core.completion" = {
                  config.engine = "nvim-cmp";
                };
                "core.export" = {};
                "core.summary" = {};
                "core.text-objects" = {};
                "core.dirman" = {
                  config = {
                    workspaces = {
                      notes = "~/Documents/neorg";
                    };
                  };
                };
              };
            };
          };
          orgmode.enable = false;
          mind-nvim.enable = false;
          todo-comments.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false; # the theme looks terrible with catppuccin
          illuminate.enable = true;
          # fastaction.enable = true;
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
              # go = ["90 130"];
            };
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

        extraPlugins = {
          # ghost-nvim = {
          #   package = pkgs.vimUtils.buildVimPlugin {
          #     name = "ghost-nvim";
          #     src = pkgs.fetchFromGitHub {
          #       owner = "subnut";
          #       repo = "nvim-ghost.nvim";
          #       rev = "v0.5.4";
          #       hash = "sha256-XldDgPqVeIfUjaRLVUMp88eHBHLzoVgOmT3gupPs+ao=";
          #     };
          #     setup = ''
          #       require('ghost').setup(),
          #     '';
          #   };
          # };
          /*
             R-nvim = {
            package = pkgs.vimUtils.buildVimPlugin {
              name = "R-nvim";
              src = pkgs.fetchFromGitHub {
                owner = "R-nvim";
                repo = "R.nvim";
                rev = "68a033246a1863c8028f7d7aae91d65fc06058c8";
                hash = "sha256-GhgzmIylttMyaV/B2QjlRcdtHW/Epw8ghQtJbQEJZN0=";
              };
              doCheck = false;
              setup = ''
                require('r').setup(),
              '';
            };
          };
          */
        };

        lazy.plugins = with pkgs.vimPlugins; {
          /*
             ${twilight-nvim.pname} = {
            lazy = true;
            package = twilight-nvim;
            setupModule = "twilight-nvim";
            cmd = ["Twilight"];
            after = ''print('hello')'';
            keys = [
              {
                key = "<leader>ut";
                mode = "n";
                action = '':Twilight<CR>'';
                silent = true;
                desc = "Toggle Twilight";
              }
            ];
          };
          */
          ${zen-mode-nvim.pname} = {
            lazy = true;
            package = zen-mode-nvim;
            setupModule = "zen-mode-nvim";
            cmd = ["ZenMode"];
            after = ''print('hello')'';
            keys = [
              {
                key = "<leader>uz";
                mode = "n";
                action = '':ZenMode<CR>'';
                silent = true;
                desc = "Toggle ZenMode";
              }
            ];
          };
          /*
             ${eyeliner-nvim.pname} = {
            package = eyeliner-nvim;
            event = ["BufEnter"];
            after = ''print('hello')'';
          };
          */
          /*
             ${quarto-nvim.pname} = {
            lazy = true;
            cmd = "QuartoPreview";
            package = quarto-nvim;
          };
          */
          ${lazygit-nvim.pname} = {
            lazy = true;
            cmd = [
              "LazyGit"
              "LazyGitConfig"
              "LazyGitCurrentFile"
              "LazyGitFilter"
              "LazyGitFilterCurrentFile"
            ];
            package = lazygit-nvim;
            setupOpts = {
              open_cmd = "zen %s";
            };
            keys = [
              {
                key = "<leader>lg";
                action = "<cmd>LazyGit<cr>";
                mode = "n";
              }
            ];
          };
          ${typst-preview-nvim.pname} = {
            lazy = true;
            cmd = "TypstPreview";
            package = typst-preview-nvim;
            setupOpts = {
              open_cmd = "zen %s";
            };
          };
          ${harpoon2.pname} = {
            lazy = true;
            cmd = "TypstPreview";
            package = harpoon2;
            keys = [
              {
                key = "<leader>ad";
                mode = "n";
                action = '':lua require("harpoon"):list():add()<CR>'';
                silent = true;
                desc = "Harpoon add";
              }
              {
                key = "<leader>as";
                mode = "n";
                action = '':lua require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())<CR>'';
                silent = true;
                desc = "Harpoon switch";
              }
            ];
          };
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
          {
            key = "-";
            action = ":Oil<CR>";
            mode = "n";
            silent = true;
            desc = "enable Oil";
          }
          {
            key = "<F5>";
            action = ":UndotreeToggle<CR>";
            mode = "n";
            silent = true;
            desc = "Toggle Undotree";
          }
        ];
      };
    };
  };
}
