#!/bin/sh

write_output() {
	local text="$1"
	local player_name="$2"
	output=$(jq -n --arg text "$text" --arg class "custom-$player_name" --arg alt "$player_name" '{"text":$text,"class":$class,"alt":$alt}')
	echo "$output"
}

on_metadata() {
	local player="$1"
	local manager="$2"
	metadata=$(playerctl --player="$player" metadata)
	track_info=""
	if [ "$player" = "spotify" ] && echo "$metadata" | grep -q ':ad:'; then
		track_info="AD PLAYING"
	else
		artist=$(echo "$metadata" | grep "xesam:artist" | cut -d '"' -f 2)
		title=$(echo "$metadata" | grep "xesam:title" | cut -d '"' -f 2)
		if [ -n "$artist" ] && [ -n "$title" ]; then
			track_info="$artist - $title"
		else
			track_info=$(playerctl --player="$player" metadata --format "{{ title }}")
		fi
	fi
	status=$(playerctl --player="$player" status)
	if [ "$status" != "Playing" ] && [ -n "$track_info" ]; then
		track_info=" $track_info"
	fi
	write_output "$track_info" "$player"
}

main() {
	# Parse command line arguments
	selected_player="$1"

	trap 'echo; exit' INT TERM
	playerctl --list-all | while read -r player; do
		if [ -n "$selected_player" ] && [ "$player" != "$selected_player" ]; then
			continue
		fi
		on_metadata "$player"
	done
}

main "$@"
