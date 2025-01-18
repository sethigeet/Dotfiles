HISTSIZE=100000
SAVEHIST=100000
HISTFILE="$XDG_DATA_HOME/zsh/history"

setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
