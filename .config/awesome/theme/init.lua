local gears = require("gears")
local beautiful = require("beautiful")

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/tokyonight.lua")

return require("theme." .. THEME)
