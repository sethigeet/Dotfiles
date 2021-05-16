# THIS FILE USES FUNCTIONS DEFINED IN OTHER FILES!

# Initialize vi mode
set -o vi

# Remap jk and kj as <escape>
bind '"jk":vi-movement-mode'
bind '"kj":vi-movement-mode'

# Change cursor shape for different vi modes.
bind "set show-mode-in-prompt on"
bind "set vi-ins-mode-string \e[6 q"
bind "set vi-cmd-mode-string \e[2 q"

bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
