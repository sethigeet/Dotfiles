if [ -n "$BASH_VERSION" ]; then
  shell="bash"
elif [ -n "$ZSH_VERSION" ]; then
  shell="zsh"
fi

eval "$(gh completion -s $shell)"
