{pkgs, ...}: {
  home.packages = with pkgs; [
    evil-helix
  ];
  home.file.".config/helix/config.toml".text = ''
    theme = "onedark"

    [editor]
    line-number = "relative"
    cursorline = true
    cursorcolumn = true
    bufferline = "always"
    auto-pairs = true

    [editor.cursor-shape]
    insert = "bar"
    normal = "block"
    select = "underline"

    [keys.normal]
    V = ["extend_line_below", "select_mode"]
    # Use system clipboard
    p = "paste_clipboard_before"
    y = "yank_main_selection_to_clipboard"
    space.c = "toggle_comments"

    [editor.file-picker]
    hidden = false

    [editor.statusline]
    left = [ "mode", "spinner", "diagnostics" ]
    center = [ "file-name", "separator", "version-control", "separator" ]
    right = [ "position", "position-percentage", "total-line-numbers" ]
    separator = "│"
    mode.normal = "NORMAL"
    mode.insert = "INSERT"
    mode.select = "SELECT"

    [editor.lsp]
    display-inlay-hints = true

  '';
}
