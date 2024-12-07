#!/bin/sh

# Touch all workspaces so that they are created by hyprland
for i in $(seq 1 9); do
  hyprctl dispatch "workspace $i"
done

# Return back to original workspace
hyprctl dispatch "workspace 1"
