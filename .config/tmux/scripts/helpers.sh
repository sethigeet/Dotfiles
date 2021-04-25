#!/bin/sh

# $1: option
# $2: default value
get_tmux_option() {
  value="$(tmux show -gqv "$1")"
  [ -n "$value" ] && echo "$value" || echo "$2"
}

# $1: option
# $2: value
set_tmux_option() {
  tmux set-option -gq "$1" "$2"
}

format_style() {
  echo "#[${1}]" | sed -e 's/,/]#[/g'
}
