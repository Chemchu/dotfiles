#!/bin/sh

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
    spotify_display_text="$artist - $title"
    spotify_display_text=$(truncate "$spotify_display_text" 30)  # Truncate the title if it exceeds 30 characters

    if [ -z "$(playerctl metadata album)" ]; then
        if [ "$player_status" = "Playing" ]; then
            echo "$spotify_display_text"
        elif [ "$player_status" = "Paused" ]; then
            echo " $spotify_display_text"
        else
            echo ""
        fi
    else
        if [ "$player_status" = "Playing" ]; then
            echo "<span class='logo'></span> $spotify_display_text"
        elif [ "$player_status" = "Paused" ]; then
            echo "<span class='logo'></span>  $spotify_display_text"
        else
            echo ""
        fi
    fi

    sleep 1

done
