local Plugin = require("plugins.plugin")

return Plugin:create({
  configure = function()
    local luasnip = require("luasnip")

    luasnip.config.set_config({
      history = true,
      -- Update more often, :h events for more info.
      updateevents = "TextChanged,TextChangedI",
    })
    -- Load snippets
    require("luasnip/loaders/from_vscode").lazy_load()
  end,
})
