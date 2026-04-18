{pkgs, ...}: {
  home.packages = with pkgs; [
    jq # Required for parsing JSON output from hyprctl
    (writeShellScriptBin "random-mouse" ''
      #!/bin/bash
      while true; do
        # Get screen dimensions using hyprctl
        screen_info=$(hyprctl monitors -j | jq -r '.[0]')
        screen_width=$(echo "$screen_info" | jq -r '.width')
        screen_height=$(echo "$screen_info" | jq -r '.height')

        # Generate random coordinates within the screen dimensions
        rand_x=$((RANDOM % screen_width))
        rand_y=$((RANDOM % screen_height))

        # Move the mouse to the random coordinates using hyprctl
        hyprctl dispatch movecursor $rand_x $rand_y

        # Wait for 30 seconds before the next move
        sleep 30
      done
    '')
  ];
}

