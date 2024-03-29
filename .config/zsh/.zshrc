if [ "$PROFILE_LOADED" != true ]; then
  source "$HOME/.config/shell/profile"
fi

colorscript random

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$XDG_DATA_HOME/zsh/oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

plugins=(
  git
  gitignore
  zsh-autosuggestions
  zsh-syntax-highlighting
  extract
  sudo
  command-not-found
  you-should-use
  vi-mode
  golang
)

# Change the cursor style according to the vi mode
VI_MODE_SET_CURSOR=true

# Enable custom completion scripts in oh-my-zsh
ZSH_DISABLE_COMPFIX=true

# Moved the cache files to XDG specificied directory
ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/.zcompdump-$SHORT_HOST-$ZSH_VERSION"

source "$ZSH/oh-my-zsh.sh"

# Load the bash completion engine for compatibility
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && if [[ ${ZSH_DISABLE_COMPFIX-} = true ]]; then
	compinit -u
else
	compinit
fi

# Source the dotfiles
file="$HOME/.config/zsh/init.zsh"
[[ ! -f $file ]] || source "$file"
unset file
