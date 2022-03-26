local beautiful = require("beautiful")

return {
  items = {
    { "awesome", require("menu.awesome"), beautiful.awesome_icon },
    { "open terminal", TERMINAL },
  },
}
