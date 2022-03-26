local awful = require("awful")

local menubar = require("menubar")
menubar.utils.terminal = TERMINAL -- Set the terminal for applications that require it

return awful.menu(require("menu.main"))
