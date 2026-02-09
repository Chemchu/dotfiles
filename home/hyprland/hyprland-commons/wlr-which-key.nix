{
  pkgs,
  lib,
  ...
}: let
  mkMenu = menu: let
    configFile =
      pkgs.writeText "config.yaml"
      (lib.generators.toYAML {} {
        font = "Iosevka Nerd Font 14";
        border = "#FF5C00ee";
        border_width = 2;
        corner_r = 0;
        anchor = "bottom-right";
        padding = 10;
        inherit menu;
      });
  in
    pkgs.writeShellScriptBin "my-menu" ''
      exec ${lib.getExe pkgs.wlr-which-key} ${configFile}
    '';
in {
  wayland.windowManager.hyprland.settings.bind = [
    ("SUPER, SPACE, exec, "
      + lib.getExe (mkMenu [
        {
          key = "f";
          desc = "Firefox";
          cmd = "firefox";
        }
        {
          key = "q";
          desc = "Kitty terminal";
          cmd = "kitty";
        }
        {
          key = "w";
          desc = "Zen browser";
          cmd = "app.zen_browser.zen";
        }
        {
          key = "s";
          desc = "Rofi";
          cmd = "rofi -show drun";
        }
      ]))
  ];
}
