#!/usr/bin/env bash

set -e

# Place holder for status left/right
place_holder="\#{prefix_highlight}"

# prefix_prompt="$(get_tmux_option prefix | tr "[:lower:]" "[:upper:]" | sed 's/C-/\^/')" \
main() {
  local -r \
    prefix_prompt="" \
    copy_prompt="" \
    sync_prompt="痢" \
    normal_prompt="I"

  local -r fallback="#{?pane_in_mode,$copy_prompt,#{?synchronize-panes,$sync_prompt,$normal_prompt}}"

  local -r highlight="#{?client_prefix,$prefix_prompt,$fallback}#[default]"

  local -r status_left_value="$(get_tmux_option "status-left")"
  set_tmux_option "status-left" "${status_left_value/$place_holder/$highlight}"
}

main
