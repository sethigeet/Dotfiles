# Load dotfiles:
for file in ~/.config/shell/{var_exports.sh,paths.sh,var_exports.sh,aliases.sh,conda_init.sh}; do
	source "$file"
done

unset file
