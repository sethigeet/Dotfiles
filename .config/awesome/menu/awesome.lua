local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

return {
  {
    "hotkeys",
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end,
  },
  { "manual", TERMINAL .. " -e man awesome" },
  { "edit config", EDITOR_CMD .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  {
    "quit",
    function()
      awesome.quit()
    end,
  },
}
