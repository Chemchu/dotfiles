{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.niri = {
    pkgs,
    lib,
    ...
  }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
    environment.etc."niri-config.kdl".source =
      "${self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri}/niri-config.kdl";
    environment.etc."niri-cheatsheet.kdl".source =
      "${self.packages.${pkgs.stdenv.hostPlatform.system}.niri-cheatsheet}";
  };

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: let
    playerctl = lib.getExe pkgs.playerctl;
    brightnessctl = lib.getExe pkgs.brightnessctl;
    grim = lib.getExe pkgs.grim;
    slurp = lib.getExe pkgs.slurp;
    wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
    notify-send = "${pkgs.libnotify}/bin/notify-send";
    noctalia = lib.getExe self'.packages.myNoctalia;
  in {
    packages.wallpaper-next = pkgs.writeShellScriptBin "wallpaper-next" ''
      tmp=$(mktemp)
      find -L "$HOME/Pictures/Wallpapers" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.webp" \) | sort > "$tmp"
      count=$(wc -l < "$tmp")
      [ "$count" -eq 0 ] && rm -f "$tmp" && exit 0
      state="''${XDG_RUNTIME_DIR:-/tmp}/wallpaper-index"
      idx=1; [ -f "$state" ] && idx=$(cat "$state")
      next=$(( (idx % count) + 1 ))
      nextpath=$(sed -n "''${next}p" "$tmp")
      rm -f "$tmp"
      echo "$next" > "$state"
      ${noctalia} ipc call wallpaper set "$nextpath" ""
    '';
    packages.wallpaper-prev = pkgs.writeShellScriptBin "wallpaper-prev" ''
      tmp=$(mktemp)
      find -L "$HOME/Pictures/Wallpapers" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.webp" \) | sort > "$tmp"
      count=$(wc -l < "$tmp")
      [ "$count" -eq 0 ] && rm -f "$tmp" && exit 0
      state="''${XDG_RUNTIME_DIR:-/tmp}/wallpaper-index"
      idx=1; [ -f "$state" ] && idx=$(cat "$state")
      prev=$(( ((idx - 2 + count) % count) + 1 ))
      prevpath=$(sed -n "''${prev}p" "$tmp")
      rm -f "$tmp"
      echo "$prev" > "$state"
      ${noctalia} ipc call wallpaper set "$prevpath" ""
    '';
    packages.niri-cheatsheet = pkgs.writeText "niri-cheatsheet.kdl" ''
      binds {
          // #"Noctalia"
          Mod+F2 hotkey-overlay-title="Keybind Cheatsheet" { spawn-sh "noctalia"; }
          Mod+S hotkey-overlay-title="Launcher" { spawn-sh "noctalia"; }
          Mod+Shift+P hotkey-overlay-title="Lock & Suspend" { spawn-sh "noctalia"; }

          // #"Applications"
          Mod+Q hotkey-overlay-title="Terminal" { spawn-sh "kitty"; }
          Mod+W hotkey-overlay-title="Browser" { spawn-sh "zen"; }
          Mod+C { close-window; }
          Mod+V { toggle-window-floating; }
          Mod+M hotkey-overlay-title="Quit Compositor" { quit; }

          // #"Column Navigation"
          Mod+H { focus-column-left; }
          Mod+L { focus-column-right; }
          Mod+Left { focus-column-left; }
          Mod+Right { focus-column-right; }
          Mod+Shift+H { move-column-left; }
          Mod+Shift+L { move-column-right; }

          // #"Workspace Navigation"
          Mod+K { focus-workspace-up; }
          Mod+J { focus-workspace-down; }
          Mod+Up { focus-workspace-up; }
          Mod+Down { focus-workspace-down; }
          Mod+Shift+K { move-window-to-workspace-up; }
          Mod+Shift+J { move-window-to-workspace-down; }

          // #"Window Management"
          Mod+F { maximize-column; }
          Mod+Shift+F { fullscreen-window; }
          Mod+Minus hotkey-overlay-title="Shrink Column" { set-column-width "-10%"; }
          Mod+Equal hotkey-overlay-title="Grow Column" { set-column-width "+10%"; }
          Mod+Shift+Minus hotkey-overlay-title="Shrink Window" { set-window-height "-10%"; }
          Mod+Shift+Equal hotkey-overlay-title="Grow Window" { set-window-height "+10%"; }

          // #"Screenshots"
          Mod+F5 hotkey-overlay-title="Screenshot Region" { spawn-sh "grim"; }
          Print hotkey-overlay-title="Screenshot Region" { spawn-sh "grim"; }

          // #"Wallpaper"
          Mod+Period hotkey-overlay-title="Next Wallpaper" { spawn-sh "wallpaper-next"; }
          Mod+Comma hotkey-overlay-title="Previous Wallpaper" { spawn-sh "wallpaper-prev"; }

          // #"Media"
          XF86AudioRaiseVolume hotkey-overlay-title="Volume Up" { spawn-sh "wpctl"; }
          XF86AudioLowerVolume hotkey-overlay-title="Volume Down" { spawn-sh "wpctl"; }
          XF86AudioMute hotkey-overlay-title="Mute Output" { spawn-sh "wpctl"; }
          XF86AudioMicMute hotkey-overlay-title="Mute Mic" { spawn-sh "wpctl"; }
          XF86AudioPlay hotkey-overlay-title="Play/Pause" { spawn-sh "playerctl"; }
          XF86AudioStop hotkey-overlay-title="Stop" { spawn-sh "playerctl"; }
          XF86AudioPause hotkey-overlay-title="Pause" { spawn-sh "playerctl"; }
          XF86AudioPrev hotkey-overlay-title="Previous Track" { spawn-sh "playerctl"; }
          XF86AudioNext hotkey-overlay-title="Next Track" { spawn-sh "playerctl"; }

          // #"Brightness"
          XF86MonBrightnessUp hotkey-overlay-title="Brightness Up" { spawn-sh "brightnessctl"; }
          XF86MonBrightnessDown hotkey-overlay-title="Brightness Down" { spawn-sh "brightnessctl"; }
          XF86KbdBrightnessUp hotkey-overlay-title="Keyboard Backlight Up" { spawn-sh "brightnessctl"; }
          XF86KbdBrightnessDown hotkey-overlay-title="Keyboard Backlight Down" { spawn-sh "brightnessctl"; }
      }
    '';
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      v2-settings = true;
      settings = {
        prefer-no-csd = true;

        cursor = {
          xcursor-theme = "everforest-cursors";
          xcursor-size = 26;
        };

        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input = {
          keyboard.xkb.layout = "es";
        };

        window-rules = [
          {
            geometry-corner-radius = 0;
          }
          {
            draw-border-with-background = false;
          }
          {
            matches = [{app-id = "kitty";}];
            default-column-width.proportion = 1.0;
          }
        ];

        binds = {
          # Niri
          "Mod+F2".spawn-sh = "${noctalia} ipc call plugin:keybind-cheatsheet toggle";
          "Mod+M".quit = {};
          "Mod+F".maximize-column = {};
          "Mod+Shift+F".fullscreen-window = {};
          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";
          "Mod+Shift+Minus".set-window-height = "-10%";
          "Mod+Shift+Equal".set-window-height = "+10%";

          # Apps
          "Mod+Q".spawn-sh = lib.getExe pkgs.kitty;
          "Mod+W".spawn-sh = "zen --name zen";
          "Mod+C".close-window = {};
          "Mod+V".toggle-window-floating = {};
          "Mod+S".spawn-sh = "${noctalia} ipc call launcher toggle";

          # Focus movement (vim-style)
          "Mod+H".focus-column-left = {};
          "Mod+L".focus-column-right = {};
          "Mod+K".focus-workspace-up = {};
          "Mod+J".focus-workspace-down = {};

          # Arrow key focus movement
          "Mod+Left".focus-column-left = {};
          "Mod+Right".focus-column-right = {};
          "Mod+Up".focus-workspace-up = {};
          "Mod+Down".focus-workspace-down = {};

          # Move windows
          "Mod+Shift+H".move-column-left = {};
          "Mod+Shift+L".move-column-right = {};
          "Mod+Shift+K".move-window-to-workspace-up = {};
          "Mod+Shift+J".move-window-to-workspace-down = {};

          # Volume
          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.15+ --limit 1";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.15-";
          "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioMicMute".spawn-sh = "wpctl set-mute @DEFAULT_SOURCE@ toggle";

          # Media keys
          "XF86AudioPlay".spawn-sh = "${playerctl} play-pause";
          "XF86AudioStop".spawn-sh = "${playerctl} pause";
          "XF86AudioPause".spawn-sh = "${playerctl} pause";
          "XF86AudioPrev".spawn-sh = "${playerctl} previous";
          "XF86AudioNext".spawn-sh = "${playerctl} next";

          # Brightness
          "XF86MonBrightnessUp".spawn-sh = "${brightnessctl} set +5%";
          "XF86MonBrightnessDown".spawn-sh = "${brightnessctl} set 5%-";
          "XF86KbdBrightnessUp".spawn-sh = "${brightnessctl} -d asus::kbd_backlight set +1";
          "XF86KbdBrightnessDown".spawn-sh = "${brightnessctl} -d asus::kbd_backlight set 1-";

          # Lock screen then suspend
          "Mod+Shift+P".spawn-sh = "${noctalia} ipc call sessionMenu lockAndSuspend";

          # Mouse scroll to switch workspaces / columns
          "Mod+WheelScrollDown".focus-workspace-down = {};
          "Mod+WheelScrollUp".focus-workspace-up = {};
          "Mod+WheelScrollRight".focus-column-right = {};
          "Mod+WheelScrollLeft".focus-column-left = {};

          # Touchpad scroll (same as wheel)
          "Mod+TouchpadScrollDown".focus-workspace-down = {};
          "Mod+TouchpadScrollUp".focus-workspace-up = {};
          "Mod+TouchpadScrollRight".focus-column-right = {};
          "Mod+TouchpadScrollLeft".focus-column-left = {};

          # Screenshot
          "Mod+F5".spawn-sh = ''region=$(${slurp} -d) && ${grim} -g "$region" - | ${wl-copy} && ${notify-send} "Captura copiada ✓"'';
          "Print".spawn-sh = ''region=$(${slurp} -d) && ${grim} -g "$region" - | ${wl-copy} && ${notify-send} "Captura copiada ✓"'';

          # Wallpaper cycling
          "Mod+Period".spawn-sh = lib.getExe self'.packages.wallpaper-next;
          "Mod+Comma".spawn-sh = lib.getExe self'.packages.wallpaper-prev;
        };
      };
    };
  };
}
