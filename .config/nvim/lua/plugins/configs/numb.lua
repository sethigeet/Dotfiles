local plugin = {}

function plugin.setup()
  require("numb").setup(Opts.plugin.numb.config)
end

function plugin.config()
  Opts.plugin["numb"] = {
    enabled = true,
    config = {
      show_numbers = true, -- Enable 'number' for the window while peeking
      show_cursorline = true, -- Enable 'cursorline' for the window while peeking
    },
  }
end

return plugin
