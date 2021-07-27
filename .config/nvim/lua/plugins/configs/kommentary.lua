local plugin = {}

function plugin.setup()
  local config = require("kommentary.config")
  config.configure_language("default", {
    prefer_single_line_comments = true,
    ignore_whitespace = true,
  })
  config.use_extended_mappings()
end

return plugin
