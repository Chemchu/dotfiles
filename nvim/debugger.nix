{pkgs, ...}: {
  vim.debugger.nvim-dap.sources = {
    # LLDB adapter for C/C++ (Rust handled by rust.dap.enable in config.nix)
    lldb = ''
      dap.adapters.lldb = {
        type = 'executable',
        command = '${pkgs.lldb}/bin/lldb-dap',
        name = 'lldb'
      }

      local lldb_cfg = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = "''${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }

      dap.configurations.cpp = lldb_cfg
      dap.configurations.c = lldb_cfg
    '';

    # Go: delve DAP server
    go = ''
      dap.adapters.go = {
        type = 'server',
        port = "''${port}",
        executable = {
          command = '${pkgs.delve}/bin/dlv',
          args = { 'dap', '-l', '127.0.0.1:''${port}' },
        },
      }

      dap.configurations.go = {
        {
          type = 'go',
          name = 'Debug file',
          request = 'launch',
          program = "''${file}",
        },
        {
          type = 'go',
          name = 'Debug package',
          request = 'launch',
          program = "''${workspaceFolder}",
        },
        {
          type = 'go',
          name = 'Attach process',
          mode = 'local',
          request = 'attach',
          processId = require('dap.utils').pick_process,
        },
        {
          type = 'go',
          name = 'Debug test file',
          request = 'launch',
          mode = 'test',
          program = "''${file}",
        },
        {
          type = 'go',
          name = 'Debug test package',
          request = 'launch',
          mode = 'test',
          program = "''${workspaceFolder}",
        },
      }
    '';

    # Node/JS/TS: vscode-js-debug adapter
    # If the dapDebugServer.js path errors, run: ls ${pkgs.vscode-js-debug}/lib/
    javascript = ''
      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = "''${port}",
        executable = {
          command = 'node',
          args = {
            '${pkgs.vscode-js-debug}/lib/node_modules/js-debug/src/dapDebugServer.js',
            "''${port}",
          },
        },
      }

      local js_cfg = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = "''${file}",
          cwd = "''${workspaceFolder}",
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = "''${workspaceFolder}",
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Debug Jest',
          runtimeExecutable = 'node',
          runtimeArgs = { './node_modules/.bin/jest', '--runInBand' },
          rootPath = "''${workspaceFolder}",
          cwd = "''${workspaceFolder}",
          console = 'integratedTerminal',
          internalConsoleOptions = 'neverOpen',
        },
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Debug Vitest',
          runtimeExecutable = 'node',
          runtimeArgs = { './node_modules/.bin/vitest', '--reporter=verbose' },
          rootPath = "''${workspaceFolder}",
          cwd = "''${workspaceFolder}",
          console = 'integratedTerminal',
          internalConsoleOptions = 'neverOpen',
        },
      }

      for _, lang in ipairs({ 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }) do
        dap.configurations[lang] = js_cfg
      end
    '';

    # Java: remote attach
    # Gradle/Spring/Quarkus:  ./gradlew bootRun --debug-jvm  OR  mvn quarkus:dev  (port 5005)
    # mvnDebug:               mvnDebug spring-boot:run                              (port 8000)
    java = ''
      dap.adapters.java = function(callback)
        local port = tonumber(vim.fn.input('Debug port [5005]: '))
        if not port or port == 0 then port = 5005 end
        callback({ type = 'server', host = '127.0.0.1', port = port })
      end

      dap.configurations.java = {
        {
          type = 'java',
          request = 'attach',
          name = 'Attach (Gradle / Spring / Quarkus — port 5005)',
          hostName = '127.0.0.1',
          port = 5005,
        },
        {
          type = 'java',
          request = 'attach',
          name = 'Attach (mvnDebug — port 8000)',
          hostName = '127.0.0.1',
          port = 8000,
        },
        {
          type = 'java',
          request = 'attach',
          name = 'Attach (custom port — prompts on start)',
          hostName = '127.0.0.1',
          port = 0,
        },
      }
    '';
  };
}
