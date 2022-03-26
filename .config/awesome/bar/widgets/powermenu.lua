local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")

local utils = require("utils")

return function()
  return wibox.widget({
    font = beautiful.font_icon,
    markup = utils.format("襤", { fg = beautiful.colors.red, bg = beautiful.bg_alt }),
    align = "center",
    valign = "center",
    widget = wibox.widget.textbox,
    buttons = gears.table.join(awful.button({}, 1, nil, function()
      awful.spawn("power-menu")
    end)),
  })
end
