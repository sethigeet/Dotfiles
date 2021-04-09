# Load dotfiles:
for file in ~/.config/shell/{var_exports.sh,paths.sh,var_exports.sh,aliases.sh,functions.sh,conda_init.sh,autocompletion.sh}; do
	source "$file"
done

unset file
