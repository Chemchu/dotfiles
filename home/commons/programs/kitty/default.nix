{ ... }:
{
  home.file.".config/kitty/kitty.conf".text = ''
    linux_display_server wayland
    wayland_titlebar_color background

    font_family FiraCode Nerd Font
    bold_font        auto
    italic_font      auto
    bold_italic_font auto

    font_size 12
    background_opacity 0.8

    # window settings
    initial_window_width 95c
    initial_window_height 35c
    window_padding_width 10
    confirm_os_window_close 0

    # Upstream colors {{{

    # Special
    background #14151e
    foreground #98b0d3

    # Black
    #color0 #151720 # --> Balcony theme
    #color8 #4f5572 # --> Balcony theme
    color0 #282c34
    color8 #282c34

    # Red
    #color1 #dd6777# --> Balcony theme
    #color9 #e26c7c# --> Balcony theme
    color1 #e06c75
    color9 #e06c75

    # Green
    #color2  #90ceaa# --> Balcony theme
    #color10 #95d3af# --> Balcony theme
    color2  #98c379
    color10 #98c379

    # Yellow
    #color3  #ecd3a0# --> Balcony theme
    #color11 #f1d8a5# --> Balcony theme
    color3  #e5c07b
    color11 #e5c07b

    # Blue
    #color4  #86aaec# --> Balcony theme
    #color12 #8baff1# --> Balcony theme
    color4  #61afef
    color12 #61afef

    # Magenta
    #color5  #c296eb# --> Balcony theme
    #color13 #c79bf0# --> Balcony theme
    color5  #c678dd
    color13 #c678dd

    # Cyan
    #color6  #93cee9# --> Balcony theme
    #color14 #98d3ee# --> Balcony theme
    color6  #56b6c2
    color14 #56b6c2

    # White
    #color7  #cbced3# --> Balcony theme
    #color15 #d0d3d8# --> Balcony theme
    color7  #abb2bf
    color15 #abb2bf

    # Cursor
    cursor #cbced3
    cursor_text_color #a5b6cf

    # Selection highlight
    selection_foreground #a5b6cf
    selection_background #1c1e27


    # The color for highlighting URLs on mouse-over
    # url_color #9ece6a
    url color #5de4c7

    # Window borders
    active_border_color #3d59a1
    inactive_border_color #101014
    bell_border_color #fffac2

    # Tab bar
    tab_bar_style fade
    tab_fade 1
    active_tab_foreground   #3d59a1
    active_tab_background   #16161e
    active_tab_font_style   bold
    inactive_tab_foreground #787c99
    inactive_tab_background #16161e
    inactive_tab_font_style bold
    tab_bar_background #101014

    # Title bar
    macos_titlebar_color #16161e

    # {{{ Keybindings
    map kitty_mod+t     new_tab_with_cwd
    # }}

  '';
}
