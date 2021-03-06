# Load dotfiles:
for file in ~/.config/shell/{paths.sh,var_exports.sh,aliases.sh,conda_init.sh}; do
  source "$file";
done;

unset file;
