vicd() {
  local dest
  dest="$(command vifm --choose-dir - "$@")"
  if [ -z "$dest" ]; then
    echo 'Directory picking cancelled/failed'
    return 1
  fi
  cd "$dest" || (echo "Invalid directory name!" && return 1)
}

function web_search() {
  google="https://www.google.com/search?q="
  ddg="https://www.duckduckgo.com/?q="
  ddgl="https://lite.duckduckgo.com/lite/?kd=-1&kp=-1&q="

  if [ "$1" = "google" ]; then
    engine="$google"
  elif [ "$1" = "ddg" ]; then
    engine="$ddg"
  elif [ "$1" = "ddgl" ]; then
    engine="$ddgl"
  fi

  shift
  lynx "$engine$*"
}

ec() {
  $EDITOR "$(which "$1")"
}
