# Load dotfiles:
file="$HOME/.config/shell/init_shell"
[ -r "$file" ] && [ -f "$file" ] && source "$file";

for file in ~/.config/zsh/{.p10k.zsh,vi-mode.zsh}; do
  source "$file"
done;

unset file;
