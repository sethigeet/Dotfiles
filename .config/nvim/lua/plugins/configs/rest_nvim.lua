local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function() require("rest-nvim").setup() end,
})
