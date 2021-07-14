# Add the repos
CDPATH="$CDPATH:$HOME/Repos"
for service in "$HOME/Repos/"*; do
  for user in "$service"/*; do
    CDPATH="$CDPATH:$user"
  done
done

# Add the configs
CDPATH="$CDPATH:$XDG_CONFIG_HOME"

# Add the scripts
CDPATH="$CDPATH:$HOME/Scripts"

# Add the home directory
CDPATH="$CDPATH:$HOME"

export CDPATH
