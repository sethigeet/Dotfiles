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

mkexe() {
  filename="$1"
  shell="${2:-sh}"

  touch "$filename"
  chmod +x "$filename"
  echo "#!/bin/$shell" >"$filename"
}

get-key-name() {
  xev | awk -F'[ )]+' \
    '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

mkrepo() {
  if [ -z "$1" ]; then
    echo "Specify the name of the repo to create" >&2
    exit 1
  fi

  # go to the repos dir
  cd "$GITUSER" || exit 1

  # create the dir for the repo and cd into it
  mkdir "$1"
  cd "$1" || exit 1

  # initialize a git repo
  git init
}

start-test-display() {
  Xephyr -ac -br -screen 1920x1000 :1 &
  export DISPLAY=:1
}
