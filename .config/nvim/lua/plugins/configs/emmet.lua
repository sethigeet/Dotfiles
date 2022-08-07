local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function() vim.g.user_emmet_leader_key = "<M-e>" end,
})
