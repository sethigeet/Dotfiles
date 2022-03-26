TERMINAL = os.getenv("TERMINAL")
EDITOR = os.getenv("EDITOR") or "nvim"
EDITOR_CMD = TERMINAL .. " -e " .. EDITOR
MODKEY = "Mod4"
ALTMODKEY = "Mod1"
THEME = "tokyonight"
INTERFACE = "enp0s31f6"

function P(...)
  print(require("utils.inspect").inspect(...))
end
