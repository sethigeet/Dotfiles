bindkey -s '^o' 'vicd\n'

# Use Ctrl+Backspace to delete a word
bindkey '^\b' backward-delete-word

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
