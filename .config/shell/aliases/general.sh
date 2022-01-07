if command -v nvim &>/dev/null; then
  alias v="nvim"
fi

if command -v yarn &>/dev/null; then
  alias yarn="yarn --use-yarnrc \$XDG_CONFIG_HOME/yarn/config"
fi

# copy the contents of a file to the clipboard
if command -v xclip &>/dev/null; then
  alias copy="xclip -selection clipboard < "
elif command -v xsel &>/dev/null; then
  alias copy="xsel -b < "
fi

# youtube
if command -v youtube-dl &>/dev/null; then
  alias ytd="youtube-dl --add-metadata -c"   # download video with audio
  alias ytad="youtube-dl --add-metadata -xc" # download audio only
fi

if command -v gallery-dl &>/dev/null; then
  alias gdl="gallery-dl"
fi

# search on lynx
alias \?="web_search ddgl"
alias \?\?="web_search google"

alias path="echo \"\$PATH\" | tr ':' '\n'"

if command -v ffprobe &>/dev/null; then
  alias get-vid-info='ffprobe -v quiet -print_format json -show_format -show_streams'
fi

if command -v ffmpeg &>/dev/null; then
  alias record-screen='ffmpeg -video_size 1920x1080 -framerate 30 -f x11grab -i :0'
fi
