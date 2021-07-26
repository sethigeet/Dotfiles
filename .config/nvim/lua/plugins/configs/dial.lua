local plugin = {}

function plugin.setup()
  local dial = require("dial")

  -- Extend functionality to toggle between true and false
  dial.augends["custom#boolean"] = dial.common.enum_cyclic({ name = "boolean", strlist = { "true", "false" } })
  dial.augends["custom#Boolean"] = dial.common.enum_cyclic({ name = "boolean", strlist = { "True", "False" } })

  table.insert(dial.config.searchlist.normal, "custom#boolean")
  table.insert(dial.config.searchlist.normal, "custom#Boolean")

  for _, mode in ipairs({ "n", "x" }) do
    vim.api.nvim_set_keymap(mode, "<C-a>", "<Plug>(dial-increment)", { silent = true })
    vim.api.nvim_set_keymap(mode, "<C-x>", "<Plug>(dial-decrement)", { silent = true })
  end

  vim.api.nvim_set_keymap("x", "g<C-a>", "<Plug>(dial-increment-additional)", { silent = true })
  vim.api.nvim_set_keymap("x", "g<C-x>", "<Plug>(dial-decrement-additional)", { silent = true })
end

return plugin
