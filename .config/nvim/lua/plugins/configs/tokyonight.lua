local plugin = {}

function plugin.setup()
  vim.g.tokyonight_style = "night"
  vim.cmd("colorscheme tokyonight")
end

return plugin
