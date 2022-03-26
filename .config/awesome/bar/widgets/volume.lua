local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local spawn = require("awful.spawn")
local gears = require("gears")
local watch = require("awful.widget.watch")

local utils = require("utils")
local vol_utils = require("utils.volume")

local MIXER_CMD = "pavucontrol"
local STEP = 2

local rows = { layout = wibox.layout.fixed.vertical }

local popup = awful.popup({
  bg = beautiful.bg,
  ontop = true,
  visible = false,
  paddings = 5,
  shape = gears.shape.rounded_rect,
  border_width = 1,
  border_color = beautiful.bg_focus,
  maximum_width = 400,
  offset = { y = 5 },
  widget = {},
})

local function build_main_line(device)
  if device.active_port ~= nil and device.ports[device.active_port] ~= nil then
    return device.properties.device_description .. " · " .. device.ports[device.active_port]
  else
    return device.properties.device_description
  end
end

local function build_rows(devices, on_checkbox_click, device_type)
  local device_rows = { layout = wibox.layout.fixed.vertical }
  for _, device in pairs(devices) do
    local checkbox = wibox.widget({
      checked = device.is_default,
      color = beautiful.bg,
      border_color = beautiful.fg,
      paddings = 3,
      shape = gears.shape.circle,
      forced_width = 20,
      forced_height = 20,
      check_color = beautiful.fg_focus,
      widget = wibox.widget.checkbox,
    })

    checkbox:connect_signal("button::press", function()
      spawn.easy_async(vol_utils.get_set_default_cmd(device_type, device.name), function()
        on_checkbox_click()
      end)
    end)

    local row = wibox.widget({
      {
        {
          {
            checkbox,
            valign = "center",
            layout = wibox.container.place,
          },
          {
            {
              text = build_main_line(device),
              align = "left",
              widget = wibox.widget.textbox,
            },
            left = 10,
            layout = wibox.container.margin,
          },
          spacing = 8,
          layout = wibox.layout.align.horizontal,
        },
        margins = 4,
        layout = wibox.container.margin,
      },
      bg = beautiful.bg,
      widget = wibox.container.background,
    })

    row:connect_signal("mouse::enter", function(c)
      c:set_bg(beautiful.bg_alt)
    end)
    row:connect_signal("mouse::leave", function(c)
      c:set_bg(beautiful.bg)
    end)

    row:connect_signal("button::press", function()
      spawn.easy_async(vol_utils.get_set_default_cmd(device_type, device.name), function()
        on_checkbox_click()
      end)
    end)

    table.insert(device_rows, row)
  end

  return device_rows
end

local function build_header_row(text)
  return wibox.widget({
    {
      markup = utils.format(text, { bold = true, size = "x-large", underline = true }),
      align = "center",
      widget = wibox.widget.textbox,
    },
    bg = beautiful.bg,
    widget = wibox.container.background,
  })
end

local function rebuild_popup()
  spawn.easy_async(vol_utils.get_list_devices_cmd(), function(stdout)
    local sinks, sources = vol_utils.extract_sinks_and_sources(stdout)

    for i = 1, #rows do
      rows[i] = nil
    end

    table.insert(rows, build_header_row("Sinks"))
    table.insert(
      rows,
      build_rows(sinks, function()
        rebuild_popup()
      end, "sink")
    )
    table.insert(rows, build_header_row("Sources"))
    table.insert(
      rows,
      build_rows(sources, function()
        rebuild_popup()
      end, "source")
    )

    popup:setup(rows)
  end)
end

local function update_text(widget, stdout)
  local mute = string.match(stdout, "%[(o%D%D?)%]") -- \[(o\D\D?)\] - [on] or [off]
  if mute == "off" then
    widget:mute()
  elseif mute == "on" then
    widget:unmute()
  end
  local volume_level = string.match(stdout, "(%d?%d?%d)%%") -- (\d?\d?\d)\%)
  volume_level = string.format("% 3d", volume_level)
  widget:set_volume_level(volume_level)
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
    set_volume_level = function(self, new_value)
      local volume_icon, fg_color
      if self.is_muted then
        volume_icon = ""
        fg_color = beautiful.fg_disabled
        self:get_children_by_id("txt")[1]:set_markup_silently(utils.format(" Muted", { fg = fg_color }))
      else
        local new_value_num = tonumber(new_value)
        if new_value_num >= 0 and new_value_num < 33 then
          volume_icon = ""
        elseif new_value_num < 66 then
          volume_icon = ""
        else
          volume_icon = ""
        end
        fg_color = beautiful.fg_focus
        self:get_children_by_id("txt")[1]:set_markup_silently(new_value .. "%")
      end
      self:get_children_by_id("icon")[1]:set_markup_silently(utils.format(volume_icon, { fg = fg_color }))
    end,
    mute = function(self)
      self.is_muted = true
    end,
    unmute = function(self)
      self.is_muted = false
    end,
  })

  widget:buttons(gears.table.join(
    awful.button({}, 3, function()
      -- Open popup
      if popup.visible then
        popup.visible = not popup.visible
      else
        rebuild_popup()
        popup:move_next_to(mouse.current_widget_geometry)
      end
    end),

    awful.button({}, 4, function()
      -- Increase vol
      spawn.easy_async(vol_utils.get_inc_volume_cmd(STEP), function(stdout)
        update_text(widget, stdout)
      end)
    end),

    awful.button({}, 5, function()
      -- Decrease vol
      spawn.easy_async(vol_utils.get_dec_volume_cmd(STEP), function(stdout)
        update_text(widget, stdout)
      end)
    end),

    awful.button({}, 2, function()
      -- Open mixer
      spawn.easy_async(MIXER_CMD)
    end),

    awful.button({}, 1, function()
      -- Toggle mute
      spawn.easy_async(vol_utils.get_tog_volume_cmd(), function(stdout)
        update_text(widget, stdout)
      end)
    end)
  ))

  watch(vol_utils.get_get_volume_cmd(), 1, update_text, widget)

  return widget
end
