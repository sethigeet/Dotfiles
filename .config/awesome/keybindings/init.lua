-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

root.buttons(require("keybindings.mouse").buttons)
root.keys(require("keybindings.global").keys)

-- NOTE: The client keybindings are loaded in the rules
