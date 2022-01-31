local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    vim.g.tokyonight_style = "night"
    require("tokyonight").colorscheme()
    -- vim.cmd("colorscheme tokyonight")
  end,
})
