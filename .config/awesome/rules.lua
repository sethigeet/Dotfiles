local beautiful = require("beautiful")
local awful = require("awful")

local client_bindings = require("keybindings.client")

awful.rules.rules = {
  -- All clients will match this rule.
  {
    rule = {},
    properties = {
      -- NOTE: The `border_width` is appropriately set in the `arrange` signal
      -- border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = client_bindings.keys,
      buttons = client_bindings.buttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
      titlebars_enabled = false,
    },
  },

  -- Floating clients.
  {
    rule_any = {
      instance = {
        "copyq", -- Includes session name in class.
        "pinentry", -- GPG key password entry
        "win0", -- Android Studio startup screen
        "^Android Emulator*", -- Android Emulator
        "^Participants*", -- Zoom meetings
      },

      class = {
        "ssh-askpass",
        "kite", -- Kite Co pilot
      },

      name = {
        "Event Tester", -- xev.
      },

      role = {
        "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
      },
    },
    properties = { floating = true },
  },

  -- Calculator
  {
    rule = { instance = "calculator" },
    properties = {
      floating = true,
      placement = awful.placement.centered,
    },
  },

  -- Add titlebars to normal clients and dialogs
  -- { rule_any = { type = { "dialog" } }, properties = { titlebars_enabled = true } },
  { rule_any = { type = { "dialog" } }, properties = { placement = awful.placement.centered } },
}
