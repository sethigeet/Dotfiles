local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local widgets = require("bar.widgets")
local widgets_utils = require("utils.widgets")

return {
  setup = function(s)
    -- Create the wibox
    local bar = awful.wibar({
      position = "top",
      height = 24,
      screen = s,
      bg = beautiful.bg_bar,
      border_width = 6,
      border_color = beautiful.bg_bar,
    })

    -- Add widgets to the wibox
    bar:setup({
      layout = wibox.layout.align.horizontal,

      -- Left widgets
      {
        layout = wibox.layout.fixed.horizontal,
        widgets_utils.component(widgets.launcher()),
        widgets.separators.space(2),
        widgets_utils.component(widgets.taglist(s)),
        widgets.separators.space(2),
        widgets_utils.component(widgets.layoutbox(s)),
        widgets.separators.space(4),
      },

      -- Middle widget
      {
        widgets_utils.component({
          widgets.tasklist(s),
          widgets.separators.alt_space(1),
          widgets.window_title(s),
          layout = wibox.layout.align.horizontal,
        }),
        halign = "center",
        valign = "center",
        layout = wibox.container.place,
      },

      -- Right widgets
      {
        layout = wibox.layout.fixed.horizontal,
        widgets.separators.space(4),
        widgets.mpris(),
        widgets.separators.space(1),
        widgets_utils.component(widgets.volume()),
        widgets.separators.space(1),
        widgets_utils.component(widgets.net()),
        widgets.separators.space(1),
        widgets_utils.component(widgets.textclock()),
        widgets.separators.space(1),
        widgets_utils.component(widgets.powermenu()),
        widgets.separators.space(1),
        widgets_utils.component(widgets.notificationmenu()),
        widgets.separators.space(1),
        {
          wibox.widget.systray(),
          margins = 3,
          widget = wibox.container.margin,
        },
      },
    })
  end,
}
