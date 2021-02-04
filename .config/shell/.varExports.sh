# export KEYTIMEOUT=1

# Set the encodings
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

# Change the editor to nvim
export EDITOR=nvim

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Change the man cmd to use bat to print out coloured output
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

