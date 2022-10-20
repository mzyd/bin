bind -n S-M-Up {
    copy-mode
    send -X clear-selection
    send -X start-of-line
    send -X start-of-line
    send -X cursor-up
    send -X start-of-line
    send -X start-of-line
    if -F "#{m:*➜\u00A0*,#{copy_cursor_line}}" {
            send -X search-forward-text "➜\u00A0"
            send -X stop-selection
            send -X -N 2 cursor-right
            send -X begin-selection
            send -X end-of-line
            send -X end-of-line
            if "#{m:*➜\u00A0?*,#{copy_cursor_line}}" {
                    send -X cursor-left
                }
        } {
            send -X end-of-line
            send -X end-of-line
            send -X begin-selection
            send -X search-backward-text "➜\u00A0"
            send -X end-of-line
            send -X end-of-line
            send -X cursor-right
            send -X stop-selection
        }
}
