#!/usr/bin/env bash

main() {
  local left_side right_side

  # Icons and Formats
  local -r right_arrow_icon="" \
    left_arrow_icon="" \
    right_chevron_icon="" \
    left_chevron_icon="" \
    session_icon="" \
    user_icon="" \
    host_icon="" \
    time_icon="" \
    date_icon="" \
    window_last_icon="" \
    window_zoomed_icon="" \
    window_marked_icon="" \
    host_format="#h" \
    session_format="#S" \
    time_format="%T" \
    date_format="%F" \
    user=$(whoami)

  # Left side of status bar
  set_tmux_option status-left-length 150

  # Prefix highlight
  # NOTE: The '#{prefix_highlight}' is replaced with the actual content in the 'prefix_highlight.sh' script
  left_side="#[fg=$FG,bg=$TC,bold] #{prefix_highlight}#[fg=$TC,bg=$TC] #[fg=$TC,bg=$BG_ALT,nobold]$right_arrow_icon"
  # Account info
  left_side="$left_side#[fg=$TC,bg=$BG_ALT] $user_icon $user $host_icon $host_format #[fg=$BG_ALT,bg=$BG,nobold]$right_arrow_icon"
  # Session info
  left_side="$left_side#[fg=$TC,bg=$BG,bold] $session_icon $session_format"

  set_tmux_option status-left "$left_side"

  # Right side of status bar
  set_tmux_option status-right-length 150

  # Time
  right_side="#[fg=$TC,bg=$BG] $time_icon $time_format"
  # Date
  right_side="$right_side #[fg=$BG_ALT,bg=$BG]$left_arrow_icon#[fg=$TC,bg=$BG_ALT] $date_icon $date_format"
  # Web Reachable
  # NOTE: The '#{online_status}' is replaced with the actual content in the 'online-status.sh' script
  right_side="$right_side #[fg=$TC,bg=$BG_ALT]$left_arrow_icon#[fg=$BG_ALT,bg=$TC] #{online_status} "

  set_tmux_option status-right "$right_side"

  # Window status
  window_status_format="#I $right_chevron_icon #W #{?window_last_flag,$window_last_icon ,}#{?current_window_flag,,}#{?window_zoomed_flag,$window_zoomed_icon ,}#{?window_marked_flag,$window_marked_icon,}"
  set_tmux_option window-status-format " #[fg=$TC]$window_status_format "

  window_status_format_current="#[fg=$BG,bg=$BG_ALT]$right_arrow_icon#[fg=$TC,bold]"
  window_status_format_current="$window_status_format_current $window_status_format"
  window_status_format_current="$window_status_format_current #[fg=$BG_ALT,bg=$BG,nobold]$right_arrow_icon"
  set_tmux_option window-status-current-format "$window_status_format_current"

  # Window separator
  set_tmux_option window-status-separator ""

  # Window status alignment
  set_tmux_option status-justify centre

  # Pane border
  set_tmux_option pane-border-style "fg=$FG_ALT,bg=default"

  # Active pane border
  set_tmux_option pane-active-border-style "fg=$TC,bg=$BG"

  # Pane number indicator
  set_tmux_option display-panes-colour "$FG_ALT"
  set_tmux_option display-panes-active-colour "$TC"

  # Clock mode
  set_tmux_option clock-mode-colour "$TC"
  set_tmux_option clock-mode-style 24

  # Message
  set_tmux_option message-style "fg=$TC,bg=$BG"

  # Command message
  set_tmux_option message-command-style "fg=$TC,bg=$BG"

  # Copy mode highlight
  set_tmux_option mode-style "bg=$TC,fg=$FG"
}

main
