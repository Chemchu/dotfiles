#!/usr/bin/env bash

# Init wallpaper daemon 
swww init &
sleep 1

# Setting up wallpaper
swww img ~/.config/wallpapers/wallpaper &

# Network applet
#nm-applet --indicator &

# The top bar
waybar &

# Mako 
#mako
