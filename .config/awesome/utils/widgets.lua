local M = {}

local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

function M.component(...)
  return {
    layout = wibox.layout.fixed.horizontal,
    {
      layout = wibox.layout.fixed.vertical,
      {
        {
          ...,
          left = 10,
          right = 10,
          top = 2,
          bottom = 2,
          widget = wibox.container.margin,
        },
        shape = gears.shape.rounded_bar,
        bg = beautiful.bg_alt,
        widget = wibox.container.background,
      },
    },
  }
end

return M
