local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    require("plugins.configs.hydra.options").init()
    require("plugins.configs.hydra.swap").init()
  end,

  utils = {
    options = require("plugins.configs.hydra.options").menu,
    swap = require("plugins.configs.hydra.swap").menu,
  },
})
