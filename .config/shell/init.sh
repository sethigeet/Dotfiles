# Load profile if not loaded yet:
if [ "$PROFILE_LOADED" != true ]; then
  source "$HOME/.config/shell/profile"
fi

# Load dotfiles:
for file in ~/.config/shell/{var_exports,paths/init,var_exports,aliases/init,functions,autocompletion}.sh; do
  source "$file"
done

unset file

# Load asdf-vm
source /opt/asdf-vm/asdf.sh
