local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

local utils = require("utils")

local function rounded_shape(size)
  return function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, size)
  end
end

local styles = {
  month = {
    padding = 4,
    bg_color = beautiful.bg,
    border_width = 0,
  },

  normal = {
    shape = rounded_shape(4),
  },

  focus = {
    fg_color = beautiful.bg_normal,
    bg_color = beautiful.bg_focus,
    markup = function(t)
      return utils.format(t, { bold = true })
    end,
    shape = rounded_shape(4),
  },

  header = {
    fg_color = beautiful.fg_focus,
    bg_color = beautiful.bg,
    markup = function(t)
      return utils.format(t, { bold = true, font = beautiful.font })
    end,
  },

  weekday = {
    fg_color = beautiful.fg,
    bg_color = beautiful.bg,
  },

  weekend = {
    fg_color = beautiful.fg_focus,
    bg_color = beautiful.bg,
    markup = function(t)
      return utils.format(t, { bold = true })
    end,
  },
}

local function decorate_cell(widget, flag, date)
  if flag == "monthheader" and not styles.monthheader then
    flag = "header"
  end

  -- highlight only today's day
  if flag == "focus" then
    local today = os.date("*t")
    if not (today.month == date.month and today.year == date.year) then
      flag = "normal"
    end
  end

  local props = styles[flag] or {}
  if props.markup and widget.get_text and widget.set_markup then
    widget:set_markup(props.markup(widget:get_text()))
  end
  -- Change bg color for weekends
  local d = { year = date.year, month = (date.month or 1), day = (date.day or 1) }
  local weekday = tonumber(os.date("%w", os.time(d)))
  local default_bg = (weekday == 0 or weekday == 6) and beautiful.bg
  local ret = wibox.widget({
    {
      {
        widget,
        halign = "center",
        widget = wibox.container.place,
      },
      margins = (props.padding or 2) + (props.border_width or 0),
      widget = wibox.container.margin,
    },
    shape = props.shape,
    shape_border_color = props.border_color or "#000000",
    shape_border_width = props.border_width or 0,
    fg = props.fg_color or beautiful.fg,
    bg = props.bg_color or default_bg,
    widget = wibox.container.background,
  })

  return ret
end

local function calendar_widget()
  local cal = wibox.widget({
    date = os.date("*t"),
    font = beautiful.font,
    fn_embed = decorate_cell,
    long_weekdays = true,
    start_sunday = false,
    widget = wibox.widget.calendar.month,
  })

  local popup = awful.popup({
    ontop = true,
    visible = false,
    shape = rounded_shape(8),
    offset = { y = 5 },
    border_width = 1,
    border_color = beautiful.border_normal,
    widget = cal,
  })

  popup:buttons(gears.table.join(
    awful.button({}, 5, function()
      local a = cal:get_date()
      a.month = a.month + 1
      cal:set_date(nil)
      cal:set_date(a)
      popup:set_widget(cal)
    end),
    awful.button({}, 4, function()
      local a = cal:get_date()
      a.month = a.month - 1
      cal:set_date(nil)
      cal:set_date(a)
      popup:set_widget(cal)
    end)
  ))

  function cal:toggle()
    if popup.visible then
      -- to faster render the calendar refresh it and just hide
      cal:set_date(nil) -- the new date is not set without removing the old one
      cal:set_date(os.date("*t"))
      popup:set_widget(nil) -- just in case
      popup:set_widget(cal)
      popup.visible = not popup.visible
    else
      awful.placement.top_right(popup, { margins = { top = 40, right = 110 }, parent = awful.screen.focused() })
      popup.visible = true
    end
  end

  return cal
end

return function()
  local props = { fg = beautiful.colors.cyan, font = beautiful.font_icon }

  local textclock = wibox.widget.textclock(
    utils.format(
      utils.format("", props) .. " %I:%M %p  " .. utils.format("", props) .. " %b %d, %Y",
      { bg = beautiful.bg_alt, font = beautiful.font }
    )
  )
  local cal = calendar_widget()
  textclock:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
      cal:toggle()
    end
  end)

  return textclock
end
