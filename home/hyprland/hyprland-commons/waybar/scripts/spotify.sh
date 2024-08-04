#!/bin/sh

# Define ANSI color codes
GREEN='\033[0;32m'
RESET='\033[0m'

truncate() {
    local input="$1"
    local length="$2"
    if [ ${#input} -gt $length ]; then
        echo "${input:0:$length}..."
    else
        echo "$input"
    fi
}

while true; do

    player_status=$(playerctl status 2>/dev/null)
    artist=$(playerctl metadata artist)
    title=$(playerctl metadata title)
    display_text="$artist - $title"
    display_text=$(truncate "$display_text" 30)  # Truncate the text if it exceeds 30 characters

    if [ -z "$(playerctl metadata album)" ]; then
        if [ "$player_status" = "Playing" ]; then
            echo "$display_text"
        elif [ "$player_status" = "Paused" ]; then
            echo " $display_text"
        else
            echo ""
        fi
    else
        if [ "$player_status" = "Playing" ]; then
            echo -e "${GREEN}${RESET} $display_text"
        elif [ "$player_status" = "Paused" ]; then
            echo -e "${GREEN}${RESET}  $display_text"
        else
            echo ""
        fi
    fi

    sleep 1

done
