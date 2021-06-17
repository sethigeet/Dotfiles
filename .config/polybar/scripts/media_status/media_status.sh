#!/bin/bash

# The name of polybar bar which houses the main spotify module and the control modules.
PARENT_BAR="main"
PARENT_BAR_PID=$(pgrep -a "polybar" | grep "$PARENT_BAR" | cut -d" " -f1)

FORMAT="{{ title }} - {{ artist }}"

# Sends $2 as message to all polybar PIDs that are part of $1
update_hooks() {
  while IFS= read -r id; do
    polybar-msg -p "$id" hook playerctl-play-pause $2 1>/dev/null 2>&1
  done < <(echo "$1")
}

PLAYERCTL_STATUS=$(playerctl status 2>/dev/null)
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
  STATUS=$PLAYERCTL_STATUS
else
  STATUS="No player is running"
fi

if [ "$1" == "--status" ]; then
  echo "$STATUS"
else
  if [ "$STATUS" = "Stopped" ]; then
    echo "Paused"
  elif [ "$STATUS" = "Paused" ]; then
    update_hooks "$PARENT_BAR_PID" 2
    echo "Paused"
  elif [ "$STATUS" = "No player is running" ]; then
    echo "$STATUS"
  else
    update_hooks "$PARENT_BAR_PID" 1
    playerctl metadata --format "$FORMAT"
  fi
fi
