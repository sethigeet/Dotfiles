# declare a list of expandable aliases to fill up later
typeset -a abbrs
abbrs=()

# write a function for adding an alias to the list mentioned above
function abbr() {
    alias "$1"
    abbrs+=("${1%%\=*}")
}

# expand any aliases in the current line buffer
function expand-abbr() {
    if [[ $LBUFFER =~ "\<(${(j:|:)abbrs})\$" ]]; then
        zle _expand_alias
        zle expand-word
    fi
    zle magic-space
}
zle -N expand-abbr

# Bind the space key to the expand-alias function above, so that space will expand any expandable aliases
bindkey ' ' expand-abbr
bindkey '^ ' magic-space     # control-space to bypass completion
bindkey -M isearch " " magic-space     # normal space during searches

# A function for expanding any aliases before accepting the line as is and executing the entered command
expand-alias-and-accept-line() {
    expand-abbr
    zle .backward-delete-char
    zle .accept-line
}
zle -N accept-line expand-alias-and-accept-line
