local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function() vim.g.matchup_matchparen_offscreen = { method = "popup" } end,
})
