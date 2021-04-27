# If not running interactively, don't do anything
[[ $- == *i* ]] || return

file="$HOME/.config/bash/init.bash"
[ -r "$file" ] && [ -f "$file" ] && source "$file"

unset file
