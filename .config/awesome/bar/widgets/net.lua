local awful = require("awful")
local beautiful = require("beautiful")
local watch = require("awful.widget.watch")
local wibox = require("wibox")

local utils = require("utils")

local TIMEOUT = 1
local WIDTH = 60

local function convert_to_h(bytes)
  local speed
  local units
  if bytes < 1000000 then
    speed = bytes / 128
    units = "Kb/s"
  elseif bytes < 1000000000 then
    speed = bytes / 131072
    units = "Mb/s"
  elseif bytes < 1000000000000 then
    speed = bytes / 134217728
    units = "Gb/s"
  else
    speed = "0"
    units = "Kb/s"
  end

  return math.floor(speed) .. " " .. units
end

return function(args)
  args = args or {}

  local widget = wibox.widget({
    {
      markup = utils.format(" ", { fg = beautiful.colors.purple }),
      font = beautiful.font_icon,
      widget = wibox.widget.textbox,
    },
    {
      id = "rx_speed",
      forced_width = WIDTH,
      align = "right",
      font = beautiful.font,
      widget = wibox.widget.textbox,
    },
    {
      markup = " ↓↑ ",
      widget = wibox.widget.textbox,
    },
    {
      id = "tx_speed",
      forced_width = WIDTH - 8, -- Accomodate the reduction in width of left part due to presence of icon
      align = "left",
      font = beautiful.font,
      widget = wibox.widget.textbox,
    },
    layout = wibox.layout.fixed.horizontal,
    set_rx_text = function(self, new_rx_speed)
      self:get_children_by_id("rx_speed")[1]:set_text(tostring(new_rx_speed))
    end,
    set_tx_text = function(self, new_tx_speed)
      self:get_children_by_id("tx_speed")[1]:set_text(tostring(new_tx_speed))
    end,

    buttons = awful.button({}, 1, function()
      awful.spawn("network")
    end),
  })

  -- make sure these are not shared across different worker/widgets (e.g. two monitors)
  -- otherwise the speed will be randomly split among the worker in each monitor
  local prev_rx = 0
  local prev_tx = 0

  local update_widget = function(wid, stdout)
    local cur_vals = utils.split(stdout, "\r\n")

    local cur_rx = 0
    local cur_tx = 0

    for i, v in ipairs(cur_vals) do
      if i % 2 == 1 then
        cur_rx = cur_rx + v
      end
      if i % 2 == 0 then
        cur_tx = cur_tx + v
      end
    end

    local speed_rx = (cur_rx - prev_rx) / TIMEOUT
    local speed_tx = (cur_tx - prev_tx) / TIMEOUT

    wid:set_rx_text(convert_to_h(speed_rx))
    wid:set_tx_text(convert_to_h(speed_tx))

    prev_rx = cur_rx
    prev_tx = cur_tx
  end

  watch(
    string.format([[bash -c "cat /sys/class/net/%s/statistics/*_bytes"]], INTERFACE),
    TIMEOUT,
    update_widget,
    widget
  )

  return widget
end
