local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    local notify = require("notify")

    notify.setup({
      -- Animation style
      stages = "slide",
    })

    vim.notify = notify
  end,
})
