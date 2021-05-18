#!/bin/sh

# short for Theme-Colour
TC="#7AA2F7"

G04=#262626
G06=#3A3A3A
G07=#444444
G10=#626262
G12=#767676

G01=#080808 #232
G02=#121212 #233
G03=#1C1C1C #234
G04=#262626 #235
G05=#303030 #236
G06=#3A3A3A #237
G07=#444444 #238
G08=#4E4E4E #239
G09=#585858 #240
G10=#626262 #241
G11=#6C6C6C #242
G12=#767676 #243

FG="$G10"
BG="$G04"

# Status options
set_tmux_option status-interval 1
set_tmux_option status on

# Basic status bar colors
set_tmux_option status-fg "$FG"
set_tmux_option status-bg "$BG"
set_tmux_option status-attr none
