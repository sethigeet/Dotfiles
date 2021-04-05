# Load dotfiles:
zsh_config="$HOME/.config/zsh/init_zsh.zsh"
bash_config="$HOME/.config/bash/init_bash.bash"

# if running zsh
if [ -n "$ZSH_VERSION" ]; then
	[ -r "$file" ] && [ -f "$file" ] && source "$zsh_config"
# if running bash
elif [ -n "$BASH_VERSION" ]; then
	[ -r "$file" ] && [ -f "$file" ] && source "$bash_config"
fi

unset file
