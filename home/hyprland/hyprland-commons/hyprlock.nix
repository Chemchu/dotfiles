{
  pkgs,
  config_path,
  lock-wallpaper,
  ...
}: {
  home = {
    packages = with pkgs; [
      hyprlock
    ];
    file."${config_path}/hypr/lock_wallpaper.jpg".source = lock-wallpaper;
    file."${config_path}/hypr/hyprlock.conf".text = ''
      # BACKGROUND
      background {
          monitor =
          path = ~/${config_path}/hypr/lock_wallpaper.jpg #path to background image
          blur_passes = 0
          contrast = 0.8916
          brightness = 0.8172
          vibrancy = 0.1696
          vibrancy_darkness = 0.0
      }

      # GENERAL
      general {
          no_fade_in = false
          grace = 0
          disable_loading_bar = true
      }

      # INPUT FIELD
      input-field {
          monitor =
          size = 250, 60
          outline_thickness = 2
          dots_size = 0.2 # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.2 # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true
          outer_color = rgba(0, 0, 0, 0)
          inner_color = rgba(0, 0, 0, 0.5)
          font_color = rgb(200, 200, 200)
          fade_on_empty = false
          font_family = Iosevka Nerd Font
          placeholder_text = <span foreground="##cdd6f4">Contraseña</span> #text for input password
          hide_input = false
          position = 0, -120
          halign = center
          valign = center
      }

      # TIME
      label {
          monitor =
          text = cmd[update:1000] echo "$(date +"%H:%M")" # get formatted date
          color = rgba(255, 255, 255, 0.9)
          font_size = 120
          font_family = Iosevka Nerd Font ExtraBold
          position = 0, -300
          halign = center
          valign = top
      }

      # USER
      label {
          monitor =
          text = cmd[update:100] echo "Hola $USER"
          color = rgba(255, 255, 255, 0.9)
          font_size = 25
          font_family = Iosevka Nerd Font
          position = 0, -40
          halign = center
          valign = center
      }
    '';
  };
}
