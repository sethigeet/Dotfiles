# Load dotfiles:
file="$HOME/.config/bash/init_bash.bash"
[ -r "$file" ] && [ -f "$file" ] && source "$file";

unset file;
