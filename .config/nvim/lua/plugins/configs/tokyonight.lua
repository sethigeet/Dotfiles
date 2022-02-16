local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    vim.g.tokyonight_style = "night"
    vim.cmd("colorscheme tokyonight")
  end,
})
