# Load dotfiles:
file="$HOME/.config/shell/init_shell"

# if running zsh
if [ -n "$ZSH_VERSION" ]; then
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
# if running bash
elif [ -n "$BASH_VERSION" ]; then
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
fi

unset file;
