local _widget_names = {
  "battery",
  "launcher",
  "layoutbox",
  "mpris",
  "net",
  "notificationmenu",
  "powermenu",
  "separators",
  "taglist",
  "tasklist",
  "textclock",
  "volume",
  "window_title",
}
local widgets = {}

for _, w in ipairs(_widget_names) do
  widgets[w] = require("bar.widgets." .. w)
end

return widgets
