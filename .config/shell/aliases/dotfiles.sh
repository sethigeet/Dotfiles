# bare repo for dotfiles
if [ -d "$HOME/Dotfiles" ]; then
  alias config="git --git-dir=$HOME/Dotfiles --work-tree=$HOME"
  alias c="config"

  alias cs="config status"
  alias ca="config add"
  alias cau="config add -u"
  alias ccm="config commit -m"
  alias cca="config commit --amend"
  alias ccan="config commit --amend --no-edit"
  alias cpush="config push origin master"
  alias cr="config reset"
  alias crh="config reset --hard"
  alias crs="config restore"
  alias crss="config restore --staged"
fi
