#!/bin/bash

# The name of polybar bar which houses the main spotify module and the control modules.
PARENT_BAR="main"
PARENT_BAR_PID=$(pgrep -a "polybar" | grep "$PARENT_BAR" | cut -d" " -f1)

FORMAT="{{ title }} - {{ artist }}"

# Sends $2 as message to all polybar PIDs that are part of $1
update_hooks() {
  while IFS= read -r id; do
    polybar-msg -p "$id" hook media-play-pause "$2" 1>/dev/null 2>&1
  done < <(echo "$1")
}

status() {
  PLAYERCTL_STATUS=$(playerctl status -a 2>/dev/null)
  EXIT_CODE=$?

  if [ $EXIT_CODE -eq 0 ]; then
    STATUS=$PLAYERCTL_STATUS
  else
    STATUS="No player is running"
  fi

  if [[ $STATUS == *Playing* ]]; then
    update_hooks "$PARENT_BAR_PID" 1
    playerctl metadata --format "$FORMAT"
  elif [[ $STATUS == *Paused* ]]; then
    update_hooks "$PARENT_BAR_PID" 2
    echo "Paused"
  elif [[ $STATUS == *Stopped* ]]; then
    update_hooks "$PARENT_BAR_PID" 2
    echo "Paused"
  elif [[ $STATUS == "No player is running" ]]; then
    update_hooks "$PARENT_BAR_PID" 2
    echo "No player is running"
  fi
}

main() {
  zscroll -l 30 \
    --delay 0.1 \
    --scroll-padding "      " \
    --match-command "$HOME/.config/polybar/scripts/media_status.sh --status" \
    --match-text "Playing" "--scroll 1" \
    --match-text "Paused" "--scroll 0" \
    --update-check true \
    "$HOME/.config/polybar/scripts/media_status.sh --status" &

  wait
}

if [ -z "$1" ]; then
  main
else
  status "$@"
fi
