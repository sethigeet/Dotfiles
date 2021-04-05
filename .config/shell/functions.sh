vicd() {
	local dest
	dest="$(command vifm --choose-dir - "$@")"
	if [ -z "$dest" ]; then
		echo 'Directory picking cancelled/failed'
		return 1
	fi
	cd "$dest" || (echo "Invalid directory name!" && return 1)
}
