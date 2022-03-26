local awful = require("awful")
local beautiful = require("beautiful")

screen.connect_signal("arrange", function(s)
  local curr_layout = awful.layout.getname()
  local border_invisible = curr_layout == "max" or curr_layout == "fullscreen"
  border_invisible = border_invisible or #s.tiled_clients == 1

  for _, c in pairs(s.clients) do
    if (border_invisible and not c.floating) or c.maximized then
      c.border_width = 0
    else
      c.border_width = beautiful.border_width
    end
  end
end)
