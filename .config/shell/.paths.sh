# LOCAL BIN
export PATH="$PATH:/home/kcsuser3/.local/bin"

# ANACONDA
export PROMPT_COMMAND="conda_auto_env;$PROMPT_COMMAND"

# ANDROID STUDIO
export ANDROID_SDK=/home/kcsuser3/Android/Sdk
export PATH="$PATH:/home/kcsuser3/Android/Sdk/platform-tools"

# FLUTTER
export PATH="$PATH:/home/kcsuser3/snap/flutter/common/flutter/bin"

# YARN
export PATH="$PATH:/home/kcsuser3/.yarn/bin"

# DENO
export PATH="$PATH:/home/kcsuser3/.deno/bin"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# GO
export PATH="$PATH:/usr/local/go/bin"

# PYENV
export PATH="/home/kcsuser3/.pyenv/bin:$PATH"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

# JULIA
export PATH="/home/kcsuser3/julia/julia-1.5.3/bin:$PATH"

# RUST
export PATH="/home/kcsuser3/.cargo/bin:$PATH"
