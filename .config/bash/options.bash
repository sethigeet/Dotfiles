# Set Options
shopt -s autocd                   # cd without typing `cd`
shopt -s histappend               # append to the history file rather than reqriting it
shopt -s dirspell                 # automatically try to correct directory names when providing tab completion
shopt -s globstar dotglob extglob # globbing options

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] \
  && . /usr/share/bash-completion/bash_completion
