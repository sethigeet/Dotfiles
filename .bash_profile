# Load dotfiles:
for file in ~/.{path,bash_prompt,condaInit,aliases}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
