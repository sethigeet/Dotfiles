export KEYTIMEOUT=10

# export LESS_TERMCAP_md=$'\e[01;31m'
# export LESS_TERMCAP_me=$'\e[0m'
# export LESS_TERMCAP_se=$'\e[0m'
# export LESS_TERMCAP_so=$'\e[01;44;33m'
# export LESS_TERMCAP_ue=$'\e[0m'
# export LESS_TERMCAP_us=$'\e[01;32m'

#! Only uncomment one of these (bat or nvim or vim)!
# Use "bat" as the man pager
if command -v bat &>/dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
else
  man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
      LESS_TERMCAP_me=$'\e[0m' \
      LESS_TERMCAP_se=$'\e[0m' \
      LESS_TERMCAP_so=$'\e[01;44;33m' \
      LESS_TERMCAP_ue=$'\e[0m' \
      LESS_TERMCAP_us=$'\e[01;32m' \
      command man "$@"
  }
fi

# use "nvim" as the man pager
# if command -v nvim &> /dev/null; then
#   export MANPAGER="nvim +Man!"
# fi

# use "vim" as the man pager
# if command -v vim &> /dev/null; then
# export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
# fi

# Anaconda auto completion
if command -v conda_auto_env &>/dev/null; then
  export PROMPT_COMMAND="conda_auto_env;$PROMPT_COMMAND"
fi

export GITUSER="sethigeet"
