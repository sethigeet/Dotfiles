# Load dotfiles:
file="$HOME/.config/shell/init_shell"
[ -r "$file" ] && [ -f "$file" ] && source "$file";
unset file;
