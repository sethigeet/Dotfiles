# Load common dotfiles:
file="$HOME/.config/shell/init_shell.sh"
[ -r "$file" ] && [ -f "$file" ] && source "$file"

# Load zsh dotfiles:
for file in ~/.config/zsh/{p10k.zsh,vi_mode.zsh}; do
	source "$file"
done

unset file
