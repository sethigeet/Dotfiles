#!/bin/sh

# short for Theme-Colour
TC="#7AA2F7"

FG="#262626"
FG_ALT=#444444
BG="#1F2335"
BG_ALT="#3B4261"

# Status options
set_tmux_option status-interval 1
set_tmux_option status on

# Basic status bar colors
set_tmux_option status-fg "$FG"
set_tmux_option status-bg "$BG"
set_tmux_option status-attr none
