local plugin = {}

function plugin.setup()
  local notify = require("notify")

  notify.setup({
    -- Animation style
    stages = "slide",
  })

  vim.notify = notify

  plugin.define_functions()
end

function plugin.define_functions()
  function Notifications()
    local messages = vim.notify.history()

    print(vim.inspect(messages))
  end

  vim.cmd("command! -nargs=0 Notifications lua Notifications()")
end

return plugin
