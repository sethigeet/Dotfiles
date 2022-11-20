local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    local icons = vim.deepcopy(require("lsp.kind"))
    for name, icon in pairs(icons) do
      icons[name] = icon .. " "
    end

    require("nvim-navic").setup({
      icons = icons,
      highlight = true,
      separator = "  ",
      depth_limit = 0,
      depth_limit_indicator = "",
      safe_output = true,
    })
  end,
})
