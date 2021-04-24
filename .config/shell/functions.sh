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

  # search or go to main page depending on number of arguments passed
  if [[ $# -gt 1 ]]; then
    # build search url:
    # join arguments passed with '+', then append to search engine URL
    url="$engine${(j:+:)@[2,-1]}"
  else
    # build main page url:
    # split by '/', then rejoin protocol (1) and domain (2) parts with '//'
    url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
  fi

  start-lynx "$url"
}

