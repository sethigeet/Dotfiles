#!/usr/bin/env bash

online_icon_default=""
offline_icon_default=" "
ping_timeout_default="3"
route_to_ping_default="www.google.com"

online_status() {
  local timeout_flag="-w"
  local number_pings_flag="-c"
  local ping_timeout="$ping_timeout_default"
  local ping_route="$route_to_ping_default"
  ping "$number_pings_flag" 1 "$timeout_flag" "$ping_timeout" -4 "$ping_route" &>/dev/null
}

print_icon() {
  if online_status; then
    printf "%s" "$online_icon_default"
  else
    printf "%s" "$offline_icon_default"
  fi
}

if [ "$1" = "-o" ]; then
  print_icon
  exit 0
fi

online_status_icon="#($CURRENT_DIR/online-status.sh -o)"
online_status_interpolation_string="\#{online_status}"

main() {
  local option option_value new_option_value

  option="status-right"
  option_value="$(get_tmux_option "$option")"
  new_option_value="${option_value/$online_status_interpolation_string/$online_status_icon}"
  set_tmux_option "$option" "$new_option_value"
}

main
