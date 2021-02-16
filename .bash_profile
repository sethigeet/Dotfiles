# Load dotfiles:
file="$HOME/.config/shell/init_shell"
[ -r "$file" ] && [ -f "$file" ] && source "$file";

file="$HOME/.config/bash/init_bash"
[ -r "$file" ] && [ -f "$file" ] && source "$file";

unset file;
