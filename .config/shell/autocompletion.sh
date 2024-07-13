enable_gh_completion=true
# NOTE: this is automatically done by 'oh-my-zsh'. if not using oh-my-zsh, then set to true
enable_pip_completion=false
enable_kitty_completion=true
enable_bun_completion=true

# 'gh' completion
if "$enable_gh_completion"; then
  if command -v gh >/dev/null; then
    eval "$(gh completion -s "$shell")"
  fi
fi

# 'pip' completion
if "$enable_pip_completion"; then
  eval "$(pip completion --"$shell")"
fi

# 'kitty' completion
if "$enable_kitty_completion"; then
  if command -v kitty >/dev/null; then
    kitty + complete setup "$shell" | source /dev/stdin
  fi
fi

# 'bun' completion
if "$enable_bun_completion"; then
  if command -v bun >/dev/null; then
    [ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
  fi
fi
