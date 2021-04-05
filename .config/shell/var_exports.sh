# export KEYTIMEOUT=1

# Set the encodings
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Change the editor to nvim
if command -v nvim &>/dev/null; then
	export EDITOR=nvim
elif command -v vim &>/dev/null; then
	export EDITOR=vim
else
	export EDITOR=vi
fi

# Preferred editor for local and remote sessions
# if [ -n $SSH_CONNECTION ]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

#! Only uncomment one of these!
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
#   export MANPAGER="nvim -c 'set ft=man' -"
# fi

# use "vim" as the man pager
# if command -v vim &> /dev/null; then
# export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
# fi

# Ignore some commands from history
export HISTORY_IGNORE="(l|la|ll|lla|ls|cd|pwd|exit|reboot|history|cd -|cd ..|..|...|....|.....|cs)"

# Anaconda auto completion
if command -v conda_auto_env &>/dev/null; then
	export PROMPT_COMMAND="conda_auto_env;$PROMPT_COMMAND"
fi

# Other XDG paths
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

# Disable less history
export LESSHISTFILE="$XDG_DATA_HOME/less/history"

# Fix some paths for programs that do not follow the XDG specs
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
# export ALSA_CONFIG_PATH="$XDG_CONFIG_HOME/alsa/asoundrc"
# export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
