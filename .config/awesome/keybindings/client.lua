local awful = require("awful")
local gears = require("gears")

local buttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
  end),
  awful.button({ MODKEY }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ MODKEY }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

local keys = gears.table.join(
  -- Move client to adjactent tags
  awful.key({ MODKEY, "Control" }, "h", function(c)
    local tag = c.screen.tags[c.screen.selected_tag.index - 1]
    if tag then
      c:move_to_tag(tag)
    end
  end, { description = "move client to left tag", group = "client" }),
  awful.key({ MODKEY, "Control" }, "l", function(c)
    local tag = c.screen.tags[c.screen.selected_tag.index + 1]
    if tag then
      c:move_to_tag(tag)
    end
  end, { description = "move client to left tag", group = "client" }),

  -- Move floating windows
  awful.key({ MODKEY }, "Up", function(c)
    if c.floating then
      c:relative_move(0, -25, 0, 0)
    end
  end, {
    description = "move the window upwards",
    group = "client",
  }),
  awful.key({ MODKEY }, "Right", function(c)
    if c.floating then
      c:relative_move(25, 0, 0, 0)
    end
  end, {
    description = "move the window rightwards",
    group = "client",
  }),
  awful.key({ MODKEY }, "Down", function(c)
    if c.floating then
      c:relative_move(0, 25, 0, 0)
    end
  end, {
    description = "move the window downwards",
    group = "client",
  }),
  awful.key({ MODKEY }, "Left", function(c)
    if c.floating then
      c:relative_move(-25, 0, 0, 0)
    end
  end, {
    description = "move the window leftwards",
    group = "client",
  }),

  -- Resize floating windows
  awful.key({ MODKEY, "Shift" }, "Up", function(c)
    if c.floating then
      c:relative_move(0, 0, 0, -25)
    end
  end, {
    description = "resize the window upwards",
    group = "client",
  }),
  awful.key({ MODKEY, "Shift" }, "Right", function(c)
    if c.floating then
      c:relative_move(0, 0, 25, 0)
    end
  end, {
    description = "resize the window rightwards",
    group = "client",
  }),
  awful.key({ MODKEY, "Shift" }, "Down", function(c)
    if c.floating then
      c:relative_move(0, 0, 0, 25)
    end
  end, {
    description = "resize the window downwards",
    group = "client",
  }),
  awful.key({ MODKEY, "Shift" }, "Left", function(c)
    if c.floating then
      c:relative_move(0, 0, -25, 0)
    end
  end, {
    description = "resize the window leftwards",
    group = "client",
  }),

  awful.key({ MODKEY }, "q", function(c)
    c:kill()
  end, { description = "close", group = "client" }),

  awful.key({ MODKEY, "Shift" }, "Return", function(c)
    c:swap(awful.client.getmaster())
  end, {
    description = "move to master",
    group = "client",
  }),

  awful.key(
    { MODKEY, "Shift" },
    "f",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),
  awful.key({ MODKEY, "Control" }, "t", function(c)
    c.ontop = not c.ontop
  end, {
    description = "toggle keep on top",
    group = "client",
  }),
  awful.key({ MODKEY, "Control" }, "s", function(c)
    c.sticky = not c.sticky
  end, {
    description = "toggle sticky",
    group = "client",
  }),
  awful.key({ MODKEY }, "m", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end, {
    description = "minimize",
    group = "client",
  })
)

return {
  buttons = buttons,
  keys = keys,
}
