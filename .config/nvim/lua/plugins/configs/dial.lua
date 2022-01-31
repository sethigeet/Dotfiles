local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    local dial = require("dial")

    -- Extend functionality to toggle between true and false
    dial.augends["custom#boolean"] = dial.common.enum_cyclic({ name = "boolean", strlist = { "true", "false" } })
    dial.augends["custom#Boolean"] = dial.common.enum_cyclic({ name = "boolean", strlist = { "True", "False" } })

    table.insert(dial.config.searchlist.normal, "custom#boolean")
    table.insert(dial.config.searchlist.normal, "custom#Boolean")
  end,

  keymaps = {
    n = {
      { "<C-a>", "<Plug>(dial-increment)" },
      { "<C-x>", "<Plug>(dial-decrement)" },

      { "g<C-a>", "<Plug>(dial-increment-additional)" },
      { "g<C-x>", "<Plug>(dial-decrement-additional)" },
    },
    x = {
      { "<C-a>", "<Plug>(dial-increment)" },
      { "<C-x>", "<Plug>(dial-decrement)" },

      { "g<C-a>", "<Plug>(dial-increment-additional)" },
      { "g<C-x>", "<Plug>(dial-decrement-additional)" },
    },
  },
})
