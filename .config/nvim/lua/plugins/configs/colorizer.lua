local plugin = {}

function plugin.setup()
  require("colorizer").setup({ "*" }, Opts.plugin.colorizer.config)
end

function plugin.config()
  Opts.plugin["colorizer"] = {
    enabled = true,
    config = {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      names = true, -- "Name" codes like Blue
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    },
  }
end

return plugin
