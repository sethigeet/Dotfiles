local beautiful = require("beautiful")
local wibox = require("wibox")

local utils = require("utils")

return {
  space = function(width)
    return wibox.widget({
      font = beautiful.font_icon,
      markup = utils.format(string.rep(" ", width), { fg = beautiful.bg_bar, bg = beautiful.bg_bar }),
      align = "center",
      valign = "center",
      widget = wibox.widget.textbox,
    })
  end,
  alt_space = function(width)
    return wibox.widget({
      font = beautiful.font_icon,
      markup = utils.format(string.rep(" ", width), { fg = beautiful.bg_alt, bg = beautiful.bg_alt }),
      align = "center",
      valign = "center",
      widget = wibox.widget.textbox,
    })
  end,
}
