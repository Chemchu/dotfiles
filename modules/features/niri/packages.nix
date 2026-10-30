{inputs, ...}: {
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
    packages = {
      myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;
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
            keyboard.xkb = {
              layout = "us,es";
              options = "grp:win_space_toggle";
            };
          };

          window-rules = [
            {
              geometry-corner-radius = 0;
            }
            {
              draw-border-with-background = false;
            }
            {
              matches = [{app-id = "ghostty";}];
              default-column-width.proportion = 1.0;
            }
          ];

          binds = {
            # Niri
            "Mod+F2".show-hotkey-overlay = {};
            "Mod+M".quit = {};
            "Mod+F".maximize-column = {};
            "Mod+Shift+F".fullscreen-window = {};
            "Mod+Minus".set-column-width = "-10%";
            "Mod+Equal".set-column-width = "+10%";
            "Mod+Shift+Minus".set-window-height = "-10%";
            "Mod+Shift+Equal".set-window-height = "+10%";
            "Mod+Shift+N".spawn-sh = "pkill -x .noctalia-wrapp; ${noctalia}";

            # Apps
            "Mod+Q".spawn-sh = lib.getExe pkgs.ghostty;
            "Mod+W".spawn-sh = "zen --name zen";
            "Mod+C".close-window = {};
            "Mod+V".toggle-window-floating = {};
            "Mod+S".spawn-sh = "${noctalia} msg panel-toggle launcher";

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
            "Mod+Shift+P".spawn-sh = "${noctalia} msg session lock-and-suspend";

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
            "Mod+Period".spawn-sh = "${noctalia} msg wallpaper-next";
            "Mod+Comma".spawn-sh = "${noctalia} msg wallpaper-previous";
          };
        };
      };
    };
  };
}
