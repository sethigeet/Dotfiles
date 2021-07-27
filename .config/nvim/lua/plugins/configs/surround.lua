local plugin = {}

function plugin.setup()
  require("surround").setup({
    prefix = "S",
  })
end

return plugin
