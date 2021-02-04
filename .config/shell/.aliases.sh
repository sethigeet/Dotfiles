# Android emulator
alias start-android-emulator="~/Android/Sdk/emulator/emulator -avd Pixel_3_API_30 -qemu -enable-kvm"

# vim
alias vim="nvim"

# vifm
alias vifm="~/.config/vifm/scripts/vifmrun"

# Changing "ls" to "exa"
alias ls="exa --color=always"
alias la="exa -ah --color=always"    # all files and dirs
alias ll="exa -lh --color=always"    # long format
alias lla="exa -lah --color=always"  # all files and dirs in long format
alias l="exa -lah --color=always"    # all files and dirs in long format
alias lt="exa -aT --color=always"   # tree listing

# Change grep to use ripgrep
alias grep="rg"

# Change find to use fd
alias find="fd"

# Change cat to use bat
alias cat="bat"

# Change ps to use procs
alias ps="procs"

# confirm before overwriting something
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# bare repo for dotfiles
alias config="git --git-dir=$HOME/Dotfiles --work-tree=$HOME"
