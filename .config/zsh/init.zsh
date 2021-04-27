# Load common dotfiles:
file="$HOME/.config/shell/init.sh"
[ -r "$file" ] && [ -f "$file" ] && source "$file"

# Load zsh dotfiles:
for file in ~/.config/zsh/{prompt,vi_mode,var_exports,keybindings}.zsh; do
  source "$file"
done

unset file
