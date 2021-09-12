local plugin = {}

function plugin.setup()
  -- Load snippets
  require("luasnip/loaders/from_vscode").lazy_load()

  plugin.keymaps()
end

function plugin.keymaps()
  local map = require("utils.map")
end

return plugin
