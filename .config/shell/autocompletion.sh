if [ -n "$BASH_VERSION" ]; then
  shell="bash"
elif [ -n "$ZSH_VERSION" ]; then
  shell="zsh"
fi

# 'gh' completion
enable_gh_completion=false
if "$enable_gh_completion"; then
  eval "$(gh completion -s $shell)"
fi

# 'pip' completion
# NOTE: this is automatically done by 'oh-my-zsh'. if not using oh-my-zsh, then set to true
enable_pip_completion=false
if "$enable_pip_completion"; then
  eval "$(pip completion --$shell)"
fi

# 'kitty' completion
enable_kitty_completion=false
if "$enable_kitty_completion"; then
  kitty + complete setup "$shell" | source /dev/stdin
fi
