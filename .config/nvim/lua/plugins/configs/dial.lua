local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    local augend = require("dial.augend")
    require("dial.config").augends:register_group({
      default = {
        augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
        augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
        augend.date.alias["%d/%m/%Y"], -- date (19/02/2022, etc.)
        augend.constant.alias.bool,
        augend.constant.new({
          elements = { "True", "False" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "and", "or" },
          word = true,
          cyclic = true,
        }),
        augend.constant.new({
          elements = { "&&", "||" },
          word = false,
          cyclic = true,
        }),
      },
    })
  end,

  keymaps = {
    n = {
      { "<C-a>", require("dial.map").inc_normal() },
      { "<C-x>", require("dial.map").dec_normal() },
    },
    v = {
      { "<C-a>", require("dial.map").inc_visual() },
      { "<C-x>", require("dial.map").dec_visual() },

      { "g<C-a>", require("dial.map").inc_gvisual() },
      { "g<C-x>", require("dial.map").dec_gvisual() },
    },
  },
})
