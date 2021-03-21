# HOME BIN
if [ -d "$HOME/.bin" ]; then 
    PATH="$HOME/.bin:$PATH"
fi

# LOCAL BIN
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

# ANDROID STUDIO
if [ -d "$HOME/Android/Sdk" ]; then
  export ANDROID_SDK="$HOME/Android/Sdk"
  export ANDROID_HOME="$HOME/Android/Sdk"
  PATH="$PATH:$HOME/Android/Sdk/platform-tools"
fi

# FLUTTER
if [ -d "$HOME/snap/flutter" ]; then
  PATH="$PATH:$HOME/snap/flutter/common/flutter/bin"
fi

# YARN
if [ -d "$HOME/.yarn" ]; then
  PATH="$PATH:$HOME/.yarn/bin"
fi

# DENO
if [ -d "$HOME/.deno" ]; then
  PATH="$PATH:$HOME/.deno/bin"
fi

# NVM
if [ -d "$HOME/.nvm" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# GO
if [ -d "$HOME/go" ]; then
  PATH="$PATH:$HOME/go/bin"
  export GOPATH="$HOME/go"
fi

# PYENV
if [ -d "$HOME/.pyenv" ]; then
  PATH="$PATH:$HOME/.pyenv/bin"
  #eval "$(pyenv init -)"
  #eval "$(pyenv virtualenv-init -)"
fi

# JULIA
if [ -d "$HOME/julia" ]; then
  PATH="$PATH:$HOME/julia/julia-1.5.3/bin"
fi

# RUST
if [ -d "$HOME/.cargo" ]; then
  PATH="$PATH:$HOME/.cargo/bin"
fi

# Doom Emacs
if [ -d "$HOME/.emacs.d" ]; then
  PATH="$PATH:$HOME/.emacs.d/bin"
fi

# Custom scripts
PATH="$PATH$(find "$HOME/Scripts" -type d -printf ":%p")"

export PATH
