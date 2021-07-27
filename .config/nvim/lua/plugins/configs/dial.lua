local plugin = {}

function plugin.setup()
  local dial = require("dial")

  -- Extend functionality to toggle between true and false
  dial.augends["custom#boolean"] = dial.common.enum_cyclic({ name = "boolean", strlist = { "true", "false" } })
  dial.augends["custom#Boolean"] = dial.common.enum_cyclic({ name = "boolean", strlist = { "True", "False" } })

  table.insert(dial.config.searchlist.normal, "custom#boolean")
  table.insert(dial.config.searchlist.normal, "custom#Boolean")

  plugin.keymaps()
end

function plugin.keymaps()
  local map = require("utils.map")

  for _, mode in ipairs({ "n", "x" }) do
    map.default_map(mode, "<C-a>", "<Plug>(dial-increment)")
    map.default_map(mode, "<C-x>", "<Plug>(dial-decrement)")
  end

  map.xmap("g<C-a>", "<Plug>(dial-increment-additional)")
  map.xmap("g<C-x>", "<Plug>(dial-decrement-additional)")
end

return plugin
