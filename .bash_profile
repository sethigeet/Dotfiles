# Load dotfiles:
file="$HOME/.config/shell/init_shell.sh"
[ -r "$file" ] && [ -f "$file" ] && source "$file"

file="$HOME/.config/bash/init_bash.bash"
[ -r "$file" ] && [ -f "$file" ] && source "$file"

unset file
