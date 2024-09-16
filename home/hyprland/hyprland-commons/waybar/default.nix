{
  pkgs,
  system_name,
  ...
} :
let
  framework_modules = if system_name == "spaceship" then "\"wireplumber\""
    else "\"network\", \"bluetooth\", \"wireplumber\", \"backlight\", \"battery\"";
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
        "spacing": 10,
        "modules-left": ["custom/launcher", "hyprland/workspaces"],
        "modules-center": ["mpris"],
        "modules-right": ["tray", ${framework_modules}, "clock"],
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
            "format": "{:L%H:%M}",
            "format-alt": "{:L%d de %B - %H:%M}",
            "tooltip-format": "<tt><small>{calendar}</small></tt>",
            "calendar": {
                "mode"          : "year",
                "mode-mon-col"  : 3,
                "on-scroll"     : 1,
                "on-click-right": "mode",
                "format": {
                    "months":     "<span color='#FCFFFC'>{}</span>",
                    "days":       "<span color='#FCFFFC'>{}</span>",
                    "weekdays":   "<span color='#FF6A6A'>{}</span>",
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
            "format": "{icon}",
            "format-muted": " ",
            "on-click": "pavucontrol &",
            "format-icons": ["", " ", " "]
        },
        "custom/launcher": {
            "format": " ",
            "tooltip" : false,
            "on-click": "rofi -show drun &",
        },
        "battery": {
          "interval": 5,
          "states": {
              "warning": 40,
              "critical": 20,
              "normal": 100
          },
          "max-length": 20,
          "format": "{icon} {capacity}%",
          "format-warning": "{icon} {capacity}%",
          "format-critical": "{icon} {capacity}%",
          "format-normal": "{icon} {capacity}%",
          "format-charging": "<span foreground='#1DB954'> {capacity}%</span>",
          "format-warning-alt": "{icon}",
          "format-critical-alt": "{icon}",
          "format-normal-alt": "{icon}",
          "format-alt": "{icon}",
          "format-icons": [
            "<span foreground='#EB4D4B'> </span>",
            "<span foreground='#FFB400'> </span>",
            "<span foreground='#1DB954'> </span>",
            "<span foreground='#1DB954'> </span>",
            "<span foreground='#1DB954'> </span>"
          ]
        },
        "network": {
            "format-wifi": "{icon}",
            "format-ethernet": " ",
            "format-disconnected": " ",
            "format-icons": ["󰤯 ", "󰤟 ", "󰤢 ", "󰤥 ", "󰤨 "],
            "tooltip-format-wifi": "{essid} ({signalStrength}%) 󰤨 ",
            "tooltip-format-ethernet": "{ifname}  ",
            "tooltip-format-disconnected": "",
            "max-length": 50
        },
        "mpris": {
            "artist-len": 20,
            "title-len": 30,
            "format": "{player_icon} {title} - {artist}",
            "format-paused": "{player_icon} {status_icon} {title} - {artist}",
            "player-icons": {
                "default": "<span foreground='#279AF1'>▶</span>",
                "mpv": "🎵",
                "spotify": "<span foreground='#1DB954'> </span>",
                "firefox": "<span foreground='#E66000'> </span>",
                "chrome": "<span foreground='#3369E8'> </span>"
            },
            "status-icons": {
                "paused": "<span foreground='#279AF1'>⏸</span>"
            },
            "tooltip": false,
            // "ignored-players": ["firefox"]
        },
        "bluetooth": {
          "format": "",
          "format-connected": " {device_alias}",
          "format-connected-battery": " {device_alias} {device_battery_percentage}%",
          //"format": "<span foreground='#0082FC'></span>",
          //"format-connected": "<span foreground='#0082FC'></span> {device_alias}",
          //"format-connected-battery": "<span foreground='#0082FC'></span> {device_alias} {device_battery_percentage}%",
          // "format-device-preference": [ "device1", "device2" ], // preference list deciding the displayed device
          "tooltip-format": "{controller_alias}\t{controller_address}\n\n{num_connections} connected",
          "tooltip-format-connected": "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}",
          "tooltip-format-enumerate-connected": "{device_alias}\t{device_address}",
          "tooltip-format-enumerate-connected-battery": "{device_alias}\t{device_address}\t{device_battery_percentage}%"
        },
        "backlight": {
          "device": "amdgpu_bl1",
          //"format": "<span foreground='#FFB400'>{icon}</span>",
          //"format-icons": ["󰹐 ", "󱩎 ", "󱩏 ", "󱩐 ", "󱩑 ", "󱩒 ", "󱩓 ", "󱩔 ", "󱩕 ", "󱩖 ", "󰛨 "]
          "format": "{icon}",
          "format-icons": ["󰃚 ", "󰃛 ", "󰃜 ", "󰃝 ", "󰃞 ", "󰃟 ", "󰃠 "]
        }
    }
  '';
}
