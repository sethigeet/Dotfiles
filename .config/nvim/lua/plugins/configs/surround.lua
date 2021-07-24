local plugin = {}

function plugin.setup()
  require("surround").setup(Opts.plugin.surround.config)
end

function plugin.config()
  Opts.plugin["surround"] = {
    enabled = true,
    config = {},
  }
end

return plugin
