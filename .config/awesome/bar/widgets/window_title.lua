local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local utils = require("utils")

return function(s)
  return awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.focused,
    layout = { layout = wibox.layout.fixed.horizontal },

    -- Notice that there is *NO* wibox.wibox prefix, it is a template,
    -- not a widget instance.
    widget_template = {
      {
        markup = utils.format(" ", { fg = beautiful.colors.blue }),
        font = beautiful.font_icon,
        widget = wibox.widget.textbox,
      },
      {
        id = "text_role",
        fg = beautiful.bg,
        font = beautiful.font,
        widget = wibox.widget.textbox,
      },
      layout = wibox.layout.align.horizontal,
    },
  })
end
