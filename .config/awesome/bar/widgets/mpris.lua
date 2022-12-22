local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local wibox = require("wibox")
local spawn = require("awful.spawn")
local watch = require("awful.widget.watch")

local separators = require("bar.widgets.separators")
local theme = require("theme")
local utils = require("utils")
local widgets_utils = require("utils.widgets")

local text_format = "{{ title }} - {{ artist }}"

local function update_text(widget, stdout)
  local statuses = utils.split(stdout, "\n")
  statuses = utils.filter(statuses, "Stopped")

  local playing_id = utils.find(statuses, "Playing")
  if playing_id ~= -1 then
    widget:set_state(true)
    spawn.easy_async("playerctl metadata -a --format '" .. text_format .. "'", function(text)
      local metadata = utils.split(text, "\n")[playing_id]
      widget:set_text(metadata)
    end)
  elseif string.match(stdout, ".*(Paused).*") == "Paused" then
    widget:set_state(false)
    widget:set_text("Paused")
  elseif string.match(stdout, ".*(Stopped).*") == "Stopped" then
    widget:set_state(false)
    widget:set_text("Paused")
  else
    widget:set_state(false)
    widget:set_text("No player is running")
  end
end

return function()
  local widget = wibox.widget({
    {
      {
        markup = utils.format(" ", { fg = theme.colors.green }),
        font = beautiful.font_icon,
        widget = wibox.widget.textbox,
      },
      valign = "center",
      layout = wibox.container.place,
    },
    {
      {
        id = "txt",
        font = beautiful.font,
        widget = wibox.widget.textbox,
      },
      step_function = wibox.container.scroll.step_functions.linear_back_and_forth,
      max_size = 225,
      speed = 50,
      layout = wibox.container.scroll.horizontal,
    },
    separators.space(1),
    widgets_utils.component({
      {
        id = "prev-btn",
        markup = utils.format("玲", { fg = theme.colors.cyan }),
        font = beautiful.font_icon,
        widget = wibox.widget.textbox,
      },
      separators.alt_space(1),
      {
        id = "play-pause-btn",
        markup = utils.format("", { fg = theme.colors.yellow }),
        font = beautiful.font_icon,
        widget = wibox.widget.textbox,
      },
      separators.alt_space(1),
      {
        id = "next-btn",
        markup = utils.format("怜", { fg = theme.colors.cyan }),
        font = beautiful.font_icon,
        widget = wibox.widget.textbox,
      },
      layout = wibox.layout.fixed.horizontal,
    }),

    layout = wibox.layout.fixed.horizontal,

    set_text = function(self, text)
      self:get_children_by_id("txt")[1]:set_text(text)
    end,
    set_state = function(self, paused)
      if paused then
        self
          :get_children_by_id("play-pause-btn")[1]
          :set_markup_silently(utils.format("", { fg = theme.colors.yellow }))
      else
        self
          :get_children_by_id("play-pause-btn")[1]
          :set_markup_silently(utils.format("", { fg = theme.colors.yellow }))
      end
    end,
  })

  widget:get_children_by_id("txt")[1]:buttons(gears.table.join(awful.button({}, 1, function()
    spawn("media-control")
  end)))
  widget:get_children_by_id("prev-btn")[1]:buttons(gears.table.join(
    awful.button({}, 1, function()
      spawn("playerctl previous")
    end),
    awful.button({}, 3, function()
      spawn("media-control")
    end)
  ))
  widget:get_children_by_id("next-btn")[1]:buttons(gears.table.join(
    awful.button({}, 1, function()
      spawn("playerctl next")
    end),
    awful.button({}, 3, function()
      spawn("media-control")
    end)
  ))
  widget:get_children_by_id("play-pause-btn")[1]:buttons(gears.table.join(
    awful.button({}, 1, function()
      spawn("playerctl play-pause")
    end),
    awful.button({}, 3, function()
      spawn("media-control")
    end)
  ))

  watch("playerctl status -a", 1, update_text, widget)

  return widget
end
