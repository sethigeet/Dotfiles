local beautiful = require("beautiful")
local wibox = require("wibox")
local watch = require("awful.widget.watch")

local utils = require("utils")

local BATTERY_STATUS_CMD = "cat /sys/class/power_supply/BAT0/capacity /sys/class/power_supply/BAT0/status"
local ICONS = {
  charging = {
    [10] = "󰢜 ",
    [20] = "󰂆 ",
    [30] = "󰂇 ",
    [40] = "󰂈 ",
    [50] = "󰢝 ",
    [60] = "󰂉 ",
    [70] = "󰢞 ",
    [80] = "󰂊 ",
    [90] = "󰂋 ",
    [100] = "󰂅 ",
  },
  discharging = {
    [10] = "󰁺 ",
    [20] = "󰁻 ",
    [30] = "󰁼 ",
    [40] = "󰁽 ",
    [50] = "󰁾 ",
    [60] = "󰁿 ",
    [70] = "󰂀 ",
    [80] = "󰂁 ",
    [90] = "󰂂 ",
    [100] = "󰁹 ",
  },
}

local function update_text(widget, stdout)
  local lines = utils.split(stdout, "\n")
  local value = lines[1]
  local status = lines[2]
  if status == "Charging" then
    widget:charge()
  else
    widget:discharge()
  end
  widget:set_battery_level(value)
end

return function()
  local widget = wibox.widget({
    {
      {
        id = "icon",
        font = beautiful.font_icon,
        resize = false,
        widget = wibox.widget.textbox,
      },
      valign = "center",
      layout = wibox.container.place,
    },
    {
      id = "txt",
      font = beautiful.font,
      widget = wibox.widget.textbox,
    },
    layout = wibox.layout.fixed.horizontal,
    set_battery_level = function(self, new_value)
      local battery_icon, level, fg_color
      local new_value_num = tonumber(new_value)
      if new_value_num <= 10 then
        level = 10
        fg_color = beautiful.colors.red
      elseif new_value_num < 20 then
        level = 10
        fg_color = beautiful.colors.red
      elseif new_value_num < 30 then
        level = 20
        fg_color = beautiful.colors.yellow
      elseif new_value_num < 40 then
        level = 30
        fg_color = beautiful.colors.yellow
      elseif new_value_num < 50 then
        level = 40
        fg_color = beautiful.colors.green
      elseif new_value_num < 60 then
        level = 50
        fg_color = beautiful.colors.green
      elseif new_value_num < 70 then
        level = 60
        fg_color = beautiful.colors.green
      elseif new_value_num < 80 then
        level = 70
        fg_color = beautiful.colors.green
      elseif new_value_num < 90 then
        level = 80
        fg_color = beautiful.colors.green
      elseif new_value_num < 100 then
        level = 90
        fg_color = beautiful.colors.green
      elseif new_value_num == 100 then
        level = 100
        fg_color = beautiful.colors.green
      end
      if self.is_charging then
        battery_icon = ICONS["charging"][level]
        fg_color = beautiful.colors.green
      else
        battery_icon = ICONS["discharging"][level]
      end
      self:get_children_by_id("txt")[1]:set_markup_silently(new_value .. "%")
      self:get_children_by_id("icon")[1]:set_markup_silently(utils.format(battery_icon, { fg = fg_color }))
    end,
    charge = function(self)
      self.is_charging = true
    end,
    discharge = function(self)
      self.is_charging = false
    end,
  })

  watch(BATTERY_STATUS_CMD, 1, update_text, widget)

  return widget
end
