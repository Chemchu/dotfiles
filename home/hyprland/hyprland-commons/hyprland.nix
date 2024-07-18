{
  pkgs,
  ...
}: let
  config_path = ".config/";
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dharmx/walls/main/centered/a_rocket_launching_in_the_sky.png";
    # replace this with the SHA256 hash of the image file
    sha256 = "160p9dvx87fpc11yczh6gzaqpb0awkdahisx4hwpsbq574y533sq";
  };

  #hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  # plugins = inputs.hyprland-plugins.packages.${pkgs.system};

  yt = pkgs.writeShellScript "yt" ''
    notify-send "Opening video" "$(wl-paste)"
    mpv "$(wl-paste)"
  '';

  playerctl = "${pkgs.playerctl}/bin/playerctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
in {
  home.packages = with pkgs; [
    libnotify
    grim
    slurp
    wl-clipboard
  ];

  # Here I import all my wallpapers
  home.file."${config_path}/background".source = wallpaper;

  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
    categories = ["X-Preferences"];
    terminal = false;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    #package = hyprland;
    systemd.enable = true;
    xwayland.enable = true;

    extraConfig = ''
      #
      # Please note not all available settings / options are set here.
      # For a full list, see the wiki
      #

      #autogenerated = 1 # remove this line to remove the warning

      # See https://wiki.hyprland.org/Configuring/Monitors/
      #monitor=,preferred,auto,auto
      monitor=DP-2,preferred,auto,auto
      monitor=Unknown-1,disable

      # monitor=DP-1, 1920x1080, 1920x0, 1
      # monitor=DP-2, 1920x1080, 0x0, 1

      # monitor=DP-1, 1920x1080, 0x0, 1
      # monitor=DP-2, 1920x1080, -1920x0, 1

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      exec-once = ags -b hypr
      exec-once = hyprctl setcursor Bibata-Modern-Classic 24
      exec-once = transmission-gtk

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.
      env = HYPRCURSOR_THEME

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

        bezier = wind, 0.05, 0.9, 0.1, 1.05
        bezier = winIn, 0.1, 1.1, 0.1, 1.05
        bezier = winOut, 0.3, -0.3, 0, 1
        bezier = liner, 1, 1, 1, 1

        animation = windows, 1, 7, wind, slide
        animation = windowsIn, 1, 7, winIn, slide
        animation = windowsOut, 1, 6, winOut, slide
        animation = windowsMove, 1, 6, wind, slide
        animation = border, 1, 1, liner
        animation = borderangle, 1, 30, liner, loop
        animation = fade, 1, 10, default
        animation = workspaces, 1, 6, wind
      }

      dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes # you probably want this
      }

      gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = off
      }

      misc {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        force_default_wallpaper = -1 # Set to 0 to disable the anime mascot wallpapers
        vrr = 1
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
      bind = $mainMod, V, togglefloating,
      bind = CTRL SHIFT, R, exec, ags -b hypr quit; ags -b hypr
      bind = $mainMod, S, exec, ags -b hypr -t launcher

      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle

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
      bind = , XF86AudioPlay,    exec, ${playerctl} play-pause
      bind = , XF86AudioStop,    exec, ${playerctl} pause
      bind = , XF86AudioPause,   exec, ${playerctl} pause
      bind = , XF86AudioPrev,    exec, ${playerctl} previous
      bind = , XF86AudioNext,    exec, ${playerctl} next
      bind = , XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle

      # Brightness
      bind = , XF86MonBrightnessUp, exec, ${brightnessctl} set +5%
      bind = , XF86MonBrightnessDown, exec, ${brightnessctl} set  5%-
      bind = , XF86KbdBrightnessUp,   exec, ${brightnessctl} -d asus::kbd_backlight set +1
      bind = , XF86KbdBrightnessDown, exec, ${brightnessctl} -d asus::kbd_backlight set  1-

      # Screenshot
      bind = $mainMod, F5, exec, grim -g "$(slurp -d)" - | wl-copy ; notify-send "Captura copiada al portapapeles"

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Youtube
      bind = , XF86Launch1,  exec, ${yt}

    '';
  };
}
