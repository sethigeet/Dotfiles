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
  PATH="$PATH:$HOME/.yarn/yarn/bin"
fi

# DENO
if [ -d "$HOME/.deno" ]; then
  PATH="$PATH:$HOME/.deno/bin"
fi

# NVM
export NVM_DIR="$XDG_DATA_HOME/nvm"
if [ -d "$NVM_DIR" ]; then
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
fi

# GO
if [ -d "$XDG_DATA_HOME/go" ]; then
  PATH="$PATH:$XDG_DATA_HOME/go/bin"
fi

# PYENV
if [ -d "$XDG_DATA_HOME/pyenv" ]; then
  PATH="$PATH:$XDG_DATA_HOME/pyenv/bin"
  #eval "$(pyenv init -)"
  #eval "$(pyenv virtualenv-init -)"
fi

# JULIA
if [ -d "$XDG_DATA_HOME/julia" ]; then
  PATH="$PATH:$XDG_DATA_HOME/julia/julia-1.5.3/bin"
fi

# RUST
if [ -d "$XDG_DATA_HOME/cargo" ]; then
  export CARGO_HOME="$XDG_DATA_HOME/cargo"
  PATH="$PATH:$XDG_DATA_HOME/cargo/bin"
fi

# Doom Emacs
if [ -d "$HOME/.emacs.d" ]; then
  PATH="$PATH:$HOME/.emacs.d/bin"
fi

# Java (OpenJDK)
if [ -d "/usr/lib/jvm/java-15-openjdk" ]; then
  export JAVA_HOME="/usr/lib/jvm/java-15-openjdk"
  PATH="$PATH:/usr/lib/jvm/java-15-openjdk/bin"
fi

export PATH
