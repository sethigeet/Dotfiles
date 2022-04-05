# Load profile if not loaded yet:
if [ "$PROFILE_LOADED" != true ]; then
  source "$HOME/.config/shell/profile"
fi

if [ -n "$BASH_VERSION" ]; then
  shell="bash"
elif [ -n "$ZSH_VERSION" ]; then
  shell="zsh"
fi

# Load dotfiles:
for file in ~/.config/shell/{var_exports,paths/init,aliases/init,functions,autocompletion,keybindings}.sh; do
  source "$file"
done

unset file

# Load asdf-vm
source /opt/asdf-vm/asdf.sh
