-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Load the globals first
require("globals")

-- Load the theme before others
require("theme")

-- Initialize some builtin functionality
require("awful.autofocus")
require("awful.rules")

-- Handle errors
require("errors")

-- Load the rest of the config
require("client")
require("fixes")
require("keybindings")
require("layouts")
require("menu")
require("rules")
require("screen")
