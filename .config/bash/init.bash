file="$HOME/.config/shell/init.sh"
[ -r "$file" ] && [ -f "$file" ] && source "$file"

for file in $HOME/.config/bash/{bash_prompt.bash,vi_mode.bash,options.bash,var_exports.bash}; do
  source "$file"
done

unset file
