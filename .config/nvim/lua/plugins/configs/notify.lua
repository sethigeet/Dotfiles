local plugin = {}

function plugin.setup()
  local notify = require("notify")

  notify.setup({
    -- Animation style
    stages = "slide",
  })

  vim.notify = notify
end

return plugin
