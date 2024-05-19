{ pkgs, ... }:
let
  wallpaper_path = ".config/hypr/wallpapers";
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dharmx/walls/main/painting/a_painting_of_a_landscape_with_trees_and_houses.jpg";
    # replace this with the SHA256 hash of the image file
    sha256 = "0jpn63ibq2p8mdm0bx76cgrlqmzhr3f746gzpwb2xbhk1df0gyfj";
  };
in
{
  home.packages = with pkgs; [
    waybar
    dunst
    libnotify
    swww
    grim
    slurp
    wl-clipboard
  ];

  # Here I import all my wallpapers
  home.file."${wallpaper_path}/wallpaper".source = wallpaper;
  home.file.".local/share/icons".source = ../../../icons;
  home.file.".local/share/icons".recursive = true;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

    extraConfig = ''
      #
      # Please note not all available settings / options are set here.
      # For a full list, see the wiki
      #

      #autogenerated = 1 # remove this line to remove the warning

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=,preferred,auto,auto
      # monitor=DP-1, 1920x1080, 1920x0, 1
      # monitor=DP-2, 1920x1080, 0x0, 1

      # monitor=DP-1, 1920x1080, 0x0, 1
      # monitor=DP-2, 1920x1080, -1920x0, 1

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      exec-once = swww-daemon ; sleep 1s ; swww img ~/${wallpaper_path}/wallpaper
      exec-once = waybar
      exec-once = dunst

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.
      #env = XCURSOR_SIZE,24
      env = HYPRCURSOR_THEME,rose-pine-hyprcursor

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
      kb_layout = es
      kb_variant =
      kb_model =
      kb_options =
      kb_rules =

      follow_mouse = 1

      touchpad {
          natural_scroll = no
      }

      sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
      # See https://wiki.hyprland.org/Configuring/Variables/ for more

      gaps_in = 3
      gaps_out = 5
      border_size = 2
      col.active_border = rgba(ffffffff)
      col.inactive_border = rgba(595959aa)

      layout = dwindle

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false
      }

      decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10

        blur {
            enabled = true
            size = 3
            passes = 1
        }

        drop_shadow = yes
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
      }

      animations {
        enabled = yes

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = myBezier, 0.05, 0.9, 0.1, 1.05

        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
      }

      dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes # you probably want this
      }

      master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true
      }

      gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = off
      }

      misc {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = -1 # Set to 0 to disable the anime mascot wallpapers
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device {
        name = epic-mouse-v1
        sensitivity = -0.5
      }

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more


      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Q, exec, kitty
      bind = $mainMod, W, exec, firefox
      bind = $mainMod, C, killactive,
      bind = $mainMod, M, exit,
      bind = $mainMod, E, exec, dolphin
      bind = $mainMod, V, togglefloating,
      bind = $mainMod, R, exec, wofi --show drun
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle
      bind = $mainMod, S, exec, rofi -show drun

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Example special workspace (scratchpad)
      #bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Manage pipewire volume
      bind = , XF86AudioRaiseVolume, execr, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.15+ --limit 1
      bind = , XF86AudioLowerVolume, execr, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.15-
      bind = , XF86AudioMute, execr, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bind = , XF86AudioMicMute, execr, wpctl set-mut @DEFAULT_AUDIO_SOURCE@ toggle

      # Screenshot
      bind = $mainMod, F5, exec, grim -g "$(slurp -d)" - | wl-copy

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

    '';
  };
}
