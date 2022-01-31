local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    vim.g.git_messenger_no_default_mappings = 1
  end,
})
