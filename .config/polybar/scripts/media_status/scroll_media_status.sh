#!/bin/sh

# see man zscroll for documentation of the following parameters
zscroll -l 30 \
  --delay 0.1 \
  --scroll-padding "      " \
  --match-command "$HOME/.config/polybar/scripts/media_status/media_status.sh --status" \
  --match-text "Playing" "--scroll 1" \
  --match-text "Paused" "--scroll 0" \
  --update-check true "$HOME/.config/polybar/scripts/media_status/media_status.sh" &

wait
