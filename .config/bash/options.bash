# Set Options
shopt -s autocd
shopt -s histappend

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] \
  && . /usr/share/bash-completion/bash_completion
