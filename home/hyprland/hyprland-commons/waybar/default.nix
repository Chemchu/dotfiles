{
  pkgs,
  systemName,
  ...
} :
let
  battery = if systemName == "framework" then "battery" else "";
in
{
  home.packages = with pkgs; [
    waybar
    jq
    playerctl
  ];

  home.file.".config/waybar/style.css".source = ./style.css;
  home.file.".config/waybar/config".text = ''
    {
        "height": 35, // Waybar height (to be removed for auto height)
        "layer": "top", // Waybar at top layer
        "margin-top": 5,
        "margin-right": 5,
        "margin-left": 5,
        "spacing": 15,
        "modules-left": ["custom/launcher", "hyprland/workspaces" ],
        "modules-right": ["tray", "wireplumber", "mpris", ${battery}],
        "modules-center": ["clock"],
        "hyprland/workspaces" : {
            "format" : "{icon}",
            "on-click" : "activate",
            "format-icons" : {
              "urgent": "",
              "active": "",
              "default": ""
            },
            "persistent-workspaces" : {
              "*": 10 // 10 workspaces by default on every monitor
            },
        },
        "hyprland/window": {
            "format": "{}"
        },
        "tray": {
            "spacing": 10
        },
        "clock": {
            "locale": "es_ES.UTF8",
            "format": "{:L%A %d de %B - %H:%M}",
            "tooltip-format": "<tt><small>{calendar}</small></tt>",
            "calendar": {
                "mode"          : "year",
                "mode-mon-col"  : 3,
                "on-scroll"     : 1,
                "on-click-right": "mode",
                "format": {
                    "months":     "<span color='#FCFFFC'>{}</span>",
                    "days":       "<span color='#FCFFFC'>{}</span>",
                    "weekdays":   "<span color='#E78F8E'>{}</span>",
                    "today":      "<span color='#279AF1'><b>{}</b></span>"
                }
            },
            "actions": {
                "on-click-right": "mode",
                "on-click-forward": "tz_up",
                "on-click-backward": "tz_down",
                "on-scroll-up": "shift_up",
                "on-scroll-down": "shift_down"
            },
            "interval": 1
        },
        "wireplumber": {
            "format": "{icon} {volume}%",
            "format-muted": "󰝟 0%",
            "on-click": "pavucontrol &",
            "format-icons": ["󰕿", "󰖀", "󰕾"]
        },
        "custom/launcher": {
            "format": "",
            "tooltip" : false,
            "on-click": "rofi -show drun &",
        },
        "battery": {
          "bat": "BAT2",
          "interval": 60,
          "states": {
              "warning": 30,
              "critical": 15
          },
          "format": "{capacity}% {icon}",
          "format-icons": ["", "", "", "", ""],
          "max-length": 25
        },
        "bluetooth": {
          // "controller": "controller1", // specify the alias of the controller if there are more than 1 on the system
          "format": " {status}",
          "format-disabled": "", // an empty format will hide the module
          "format-connected": " {num_connections} connected",
          "tooltip-format": "{controller_alias}\t{controller_address}",
          "tooltip-format-connected": "{controller_alias}\t{controller_address}\n\n{device_enumerate}",
          "tooltip-format-enumerate-connected": "{device_alias}\t{device_address}"
        },
        "mpris": {
            "artist-len": 10,
            "title-len": 15,
            "format": "{player_icon}  {title} - {artist}",
            "format-paused": "{player_icon}  {status_icon} <i>{title} - {artist}</i>",
            "player-icons": {
                "default": "<span foreground='#279AF1'>▶</span>",
                "mpv": "🎵",
                "spotify": "<span foreground='#1DB954'></span>",
                "firefox": "<span foreground='#E66000'></span>",
                "chrome": "<span foreground='#3369E8'></span>"
            },
            "status-icons": {
                "paused": "<span foreground='#279AF1'>⏸</span>"
            },
            "tooltip": false,
            // "ignored-players": ["firefox"]
        }
    }
  '';
}
