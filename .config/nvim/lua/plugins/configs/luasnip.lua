local plugin = {}

function plugin.setup()
  local luasnip = require("luasnip")

  luasnip.config.set_config({
    history = true,
    -- Update more often, :h events for more info.
    updateevents = "TextChanged,TextChangedI",
  })
  -- Load snippets
  require("luasnip/loaders/from_vscode").lazy_load()

  plugin.keymaps()
end

function plugin.keymaps()
  local map = require("utils.wrappers").map
end

return plugin
