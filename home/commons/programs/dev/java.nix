{ pkgs, lib, ... }:
{
  home = {
    packages = with pkgs; [
      # Packages needed for Java
      temurin-bin-17
    ];
  };

  programs.nixvim = {
    plugins.nvim-jdtls = {
      enable = true;
      cmd = [
        (lib.getExe pkgs.jdt-language-server)
      ];
    };

    plugins.lsp = {
      enable = true;
      servers = {
        java-language-server = { enable = true; };
      };
    };
  };
}
/* {
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      # Packages needed for Java
      temurin-bin-17
    ];
  };

  programs.nixvim = {
    enable = true;

    plugins = {
      lsp = {
        enable = true;
        servers = {
          jdtls = {
            enable = true;
            lspConfig = {
              name = "jdtls";
              cmd = "${pkgs.jdtls}/bin/jdtls";
              filetypes = ["java"];
            };
          };
        };
      };

      dap = {
        enable = true;
        config = {
          java = {
            adapters = {
              javaDebug = {
                type = "executable";
                command = "java";
                args = [
                  "-jar"
                  "${pkgs.vscode-java-debug}/share/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
                ];
              };
            };

            configurations = [
              {
                type = "java";
                name = "Debug (Launch) - Current File";
                request = "launch";
                #mainClass = "${file}";
                #projectName = "${workspaceFolderBasename}";
              }
            ];
          };
        };
      };
    };
  };
}
*/
