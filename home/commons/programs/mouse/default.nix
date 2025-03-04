{pkgs, ...}: {
  # Define a custom package for your script
  home.packages = with pkgs; [
    xdotool
    (writeShellScriptBin "random-mouse" ''
      #!/bin/bash
      while true; do
        screen_width=$(xdotool getdisplaygeometry | awk '{print $1}')
        screen_height=$(xdotool getdisplaygeometry | awk '{print $2}')
        rand_x=$((RANDOM % screen_width))
        rand_y=$((RANDOM % screen_height))
        xdotool mousemove $rand_x $rand_y
        sleep 30
      done
    '')
  ];
}

