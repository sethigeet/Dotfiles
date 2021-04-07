# Add color to some shell commands
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias diff="diff --color=auto"
alias ip="ip -color=auto"
alias dmesg="dmesg --color=auto"

# Android emulator
if [ -d "$HOME/Android/Sdk" ]; then
	alias start-android-emulator="$HOME/Android/Sdk/emulator/emulator -avd Pixel_4_API_30 -qemu -enable-kvm"
fi

# nvim
if command -v nvim &>/dev/null; then
	alias v="nvim"
fi

# vifm
if command -v vifm &>/dev/null; then
	alias vifm="$HOME/.config/vifm/scripts/vifmrun"
fi

# Changing "ls" to "exa"
if command -v exa &>/dev/null; then
	alias ls="exa --icons --color=auto --group-directories-first"
	alias la="exa -ah --icons --color=auto --group-directories-first"   # all files and dirs
	alias ll="exa -lh --icons --color=auto --group-directories-first"   # long format
	alias lla="exa -lah --icons --color=auto --group-directories-first" # all files and dirs in long format
	alias l="exa -lah --icons --color=auto --group-directories-first"   # all files and dirs in long format
	alias lt="exa -aT --icons --color=auto"                             # tree listing
else
	alias ls="ls --color=auto --group-directories-first"       # visible files and dirs
	alias la="ls -ah --color=auto --group-directories-first"   # all files and dirs
	alias ll="ls -lh --color=auto --group-directories-first"   # long format
	alias lla="ls -lah --color=auto --group-directories-first" # all files and dirs in long format
	alias l="ls -lah --color=auto --group-directories-first"   # all files and dirs in long format
fi

# Change grep to use ripgrep
# if command -v rg &> /dev/null; then
#   alias grep="rg"
# fi

# Change find to use fd
# if command -v fd &> /dev/null; then
#   alias find="fd"
# fi

# Change cat to use bat
if command -v bat &>/dev/null; then
	alias cat="bat"
fi

# Change ps to use procs
# if command -v procs &> /dev/null; then
#   alias ps="procs"
# fi

# confirm before overwriting something
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"

# make direcotries
alias mkd="mkdir -pv"

# bare repo for dotfiles
if [ -d "$HOME/Dotfiles" ]; then
	alias config="git --git-dir=$HOME/Dotfiles --work-tree=$HOME"
	alias c="config"

	alias cs="config status"
	alias ca="config add"
	alias cau="config add -u"
	alias ccm="config commit -m"
	alias cca="config commit --amend"
	alias ccan="config commit --amend --no-edit"
	alias cpush="config push origin master"
	alias cr="config restore"
	alias crs="config restore --staged"
fi

# find the size of a dir
alias hsize="du -hs"

# make a file executable
alias mkexe="chmod +x"

# copy the contents of a file to the clipboard
alias copy="xclip -selection clipboard < "

# use the package manager
alias pac="sudo pacman"

# systemd commands
alias SS="sudo systemctl"

# kill programs
alias ka="killall"

# youtube
if command -v youtube-dl &>/dev/null; then
	alias ytd="youtube-dl --add-metadata -c"   # download video with audio
	alias ytad="youtube-dl --add-metadata -xc" # download audio only
fi
