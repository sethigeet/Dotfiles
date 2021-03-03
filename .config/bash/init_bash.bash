file="$HOME/.config/shell/init_shell.sh"
[ -r "$file" ] && [ -f "$file" ] && source "$file";

for file in $HOME/.config/bash/{bash_prompt.bash,vi-mode.bash}; do
  source "$file"
done;

unset file;
