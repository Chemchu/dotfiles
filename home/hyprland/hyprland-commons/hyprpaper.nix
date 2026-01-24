{
  pkgs,
  lib,
  config_path,
  wallpaper,
  wallpapers ? [],
  ...
}: let
  wallpapersDir = pkgs.runCommand "wallpapers" {} ''
    mkdir -p $out
    ${pkgs.lib.concatImapStringsSep "\n" (i: wp: ''
        cp ${wp} $out/wallpaper_${toString i}.jpg
      '')
      wallpapers}
  '';
in {
  home = {
    packages = with pkgs; [
      hyprpaper
      (pkgs.writeShellScriptBin "wallpaper-switch" ''
        #!/usr/bin/env bash

        WALLPAPERS_DIR="${wallpapersDir}"
        STATE_DIR="$HOME/.local/share/hyprpaper"
        STATE_FILE="$STATE_DIR/current_wallpaper"
        TARGET="$STATE_DIR/current-background.jpg"

        mkdir -p "$STATE_DIR"
        mapfile -t WALLPAPERS < <(find "$WALLPAPERS_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort)

        if [ ''${#WALLPAPERS[@]} -eq 0 ]; then
          echo "No wallpapers found in $WALLPAPERS_DIR"
          exit 1
        fi

        CURRENT_INDEX=0
        if [ -f "$STATE_FILE" ]; then
          CURRENT_INDEX=$(cat "$STATE_FILE")
        fi

        case "$1" in
          next)
            NEW_INDEX=$(( (CURRENT_INDEX + 1) % ''${#WALLPAPERS[@]} ))
            ;;
          prev)
            NEW_INDEX=$(( (CURRENT_INDEX - 1 + ''${#WALLPAPERS[@]}) % ''${#WALLPAPERS[@]} ))
            ;;
          *)
            echo "Usage: wallpaper-switch [next|prev]"
            exit 1
            ;;
        esac

        NEW_WALLPAPER="''${WALLPAPERS[$NEW_INDEX]}"

        rm -f "$TARGET"
        cp "$NEW_WALLPAPER" "$TARGET"
        chmod 644 "$TARGET"

        echo "$NEW_INDEX" > "$STATE_FILE"

        if pgrep -x hyprpaper > /dev/null; then
          hyprctl hyprpaper unload "$TARGET" 2>/dev/null || true
          sleep 0.1
          hyprctl hyprpaper preload "$TARGET" 2>/dev/null || true
          hyprctl hyprpaper wallpaper ",$TARGET" 2>/dev/null || true
          echo "Switched to wallpaper $((NEW_INDEX + 1))/''${#WALLPAPERS[@]}: $(basename "$NEW_WALLPAPER")"
        else
          echo "Wallpaper file updated to $((NEW_INDEX + 1))/''${#WALLPAPERS[@]}: $(basename "$NEW_WALLPAPER")"
          echo "Note: hyprpaper is not running. Restarting hyprpaper..."
          killall hyprpaper 2>/dev/null || true
          hyprpaper &
          sleep 0.5
        fi
      '')
    ];
    file."${config_path}/hypr/background.jpg".source = wallpaper;
    file."${config_path}/hypr/hyprpaper.conf".text = ''
      preload = ~/.local/share/hyprpaper/current-background.jpg
      wallpaper = , ~/.local/share/hyprpaper/current-background.jpg
      ipc = on
    '';
  };

  home.activation.initCurrentWallpaper = lib.hm.dag.entryAfter ["writeBoundary"] ''
    STATE_DIR="$HOME/.local/share/hyprpaper"
    $DRY_RUN_CMD mkdir -p "$STATE_DIR"
    if [ ! -f "$STATE_DIR/current-background.jpg" ]; then
      $DRY_RUN_CMD cp $VERBOSE_ARG \
        "$HOME/${config_path}/hypr/background.jpg" \
        "$STATE_DIR/current-background.jpg"
      $DRY_RUN_CMD chmod 644 "$STATE_DIR/current-background.jpg"
    fi
  '';
}
