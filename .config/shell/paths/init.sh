# Load dotfiles:

for file in ~/.config/shell/paths/{path,cdpath}.sh; do
  source "$file"
done
