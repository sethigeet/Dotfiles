local gears = require("gears")
local awful = require("awful")

local menu = require("menu")

return {
  buttons = gears.table.join(awful.button({}, 3, function()
    menu:toggle()
  end)),
}
