change-cursor() {
  if [ -z "$1" ]; then
    return;
  elif [[ $1 == "block" ]]; then
    echo -ne '\e[1 q'
  elif [[ $1 == "beam" ]]; then
    echo -ne '\e[5 q'
  fi
}
