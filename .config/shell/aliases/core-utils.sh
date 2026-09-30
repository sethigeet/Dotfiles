# Changing "ls" to "eza"
if command -v eza &>/dev/null; then
  alias ls="eza --icons --color=auto --group-directories-first"
  alias la="eza -ah --icons --color=auto --group-directories-first"   # all files and dirs
  alias ll="eza -lh --icons --color=auto --group-directories-first"   # long format
  alias lla="eza -lah --icons --color=auto --group-directories-first" # all files and dirs in long format
  alias l="eza -lah --icons --color=auto --group-directories-first"   # all files and dirs in long format
  alias lt="eza -aT --icons --color=auto"                             # tree listing
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
alias cdtmp='cd $(mktemp -d)'

# find the size of a dir
alias hsize="du -hs"

# make a file executable
alias chmox="chmod +x"

# use the package manager
alias pac="sudo pacman"

# systemd commands
alias SS="sudo systemctl"

# kill programs
alias ka="killall"
