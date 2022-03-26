local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")

local function get_mapping_fn(func, arg)
  return function()
    func(arg)
  end
end

-- Store the previous layouts for each tag so that they can be restored after getting out of max mode
local layouts_by_tag = {
  max = {},
  fullscreen = {},
}
local function toggle_layout(name, layout)
  local curr_layout = awful.layout.getname()
  local curr_tag = awful.screen.focused().selected_tag
  if curr_layout == name then
    awful.layout.set(awful.layout.layouts[layouts_by_tag[name][curr_tag.name]])
    layouts_by_tag[name][curr_tag] = nil
    return
  end

  layouts_by_tag[name][curr_tag.name] = awful.layout.get_tag_layout_index(curr_tag)
  awful.layout.set(layout)
end

local keys = gears.table.join(
  -- WM controls
  awful.key({ MODKEY, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ MODKEY, "Control" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),

  -- General
  awful.key({ MODKEY }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),

  -- Tags
  awful.key({ MODKEY }, "Tab", awful.tag.viewnext, { description = "view next", group = "tag" }),
  awful.key({ MODKEY, "Shift" }, "Tab", awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ MODKEY, "Shift" }, "h", awful.tag.viewprev, { description = "view previous", group = "tag" }),
  awful.key({ MODKEY, "Shift" }, "l", awful.tag.viewnext, { description = "view next", group = "tag" }),
  awful.key({ ALTMODKEY }, "Tab", awful.tag.history.restore, { description = "go back", group = "tag" }),

  -- Moving between windows
  awful.key({ MODKEY }, "j", get_mapping_fn(awful.client.focus.byidx, 1), {
    description = "focus next by index",
    group = "client",
  }),
  awful.key({ MODKEY }, "k", get_mapping_fn(awful.client.focus.byidx, -1), {
    description = "focus previous by index",
    group = "client",
  }),

  -- Moving windows
  awful.key({ MODKEY, "Shift" }, "j", get_mapping_fn(awful.client.swap.byidx, 1), {
    description = "swap with next client by index",
    group = "client",
  }),
  awful.key({ MODKEY, "Shift" }, "k", get_mapping_fn(awful.client.swap.byidx, -1), {
    description = "swap with previous client by index",
    group = "client",
  }),

  -- Resize windows
  awful.key({ MODKEY }, "l", get_mapping_fn(awful.tag.incmwfact, 0.05), {
    description = "increase master width factor",
    group = "layout",
  }),
  awful.key({ MODKEY }, "h", get_mapping_fn(awful.tag.incmwfact, -0.05), {
    description = "decrease master width factor",
    group = "layout",
  }),

  awful.key({ MODKEY }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
  awful.key({ MODKEY }, "grave", function()
    awful.client.focus.history.previous()
    if client.focus then
      client.focus:raise()
    end
  end, {
    description = "go back",
    group = "client",
  }),
  awful.key({ MODKEY, "Control" }, "m", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, {
    description = "restore minimized (=unminimize)",
    group = "client",
  }),

  -- Change number of master nodes
  awful.key({ MODKEY, "Shift" }, "d", function()
    awful.tag.incnmaster(1, nil, true)
  end, {
    description = "increase the number of master clients",
    group = "layout",
  }),
  awful.key({ MODKEY }, "d", function()
    awful.tag.incnmaster(-1, nil, true)
  end, {
    description = "decrease the number of master clients",
    group = "layout",
  }),

  -- Change layouts
  awful.key({ MODKEY, "Control" }, ".", get_mapping_fn(awful.layout.inc, 1), {
    description = "select next",
    group = "layout",
  }),
  awful.key({ MODKEY, "Control" }, ",", get_mapping_fn(awful.layout.inc, -1), {
    description = "select previous",
    group = "layout",
  }),

  -- Toggle max layout
  awful.key({ MODKEY }, "f", function()
    toggle_layout("max", awful.layout.suit.max)
  end, {
    description = "toggle max layout",
    group = "layout",
  }),

  -- Toggle fullscreen layout
  awful.key({ MODKEY, "Control" }, "f", function()
    toggle_layout("fullscreen", awful.layout.suit.max.fullscreen)
  end, {
    description = "toggle fullscreen layout",
    group = "layout",
  })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  keys = gears.table.join(
    keys,
    -- View tag only
    awful.key({ MODKEY }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, {
      description = "view tag #" .. i,
      group = "tag",
    }),
    -- Toggle tag display
    awful.key({ MODKEY, "Control" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, {
      description = "toggle tag #" .. i,
      group = "tag",
    }),
    -- Move client to tag
    awful.key({ MODKEY, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, {
      description = "move focused client to tag #" .. i,
      group = "tag",
    }),
    -- Toggle tag on focused client
    awful.key({ MODKEY, "Control", "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end, {
      description = "toggle focused client on tag #" .. i,
      group = "tag",
    }),
    -- Swap tags
    awful.key({ MODKEY, ALTMODKEY }, "#" .. i + 9, function()
      local screen = awful.screen.focused()

      local curr_tag = screen.selected_tag
      local other_tag = screen.tags[i]
      curr_tag:swap(other_tag)
    end, {
      description = "swap current tag with #" .. i,
      group = "tag",
    })
  )
end

return {
  keys = keys,
}
