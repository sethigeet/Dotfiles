local ls = require("luasnip")
local sn = ls.sn
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta

local require_var = function(args, _)
  local text = args[1][1] or ""
  local split = vim.split(text, ".", { plain = true })

  local options = {}
  for len = 0, #split - 1 do
    table.insert(options, t(table.concat(vim.list_slice(split, #split - len, #split), "_")))
  end

  return sn(nil, {
    c(1, options),
  })
end

return {
  filetypes = { "lua" },
  snippets = {
    ignore = "--stylua: ignore",

    req = fmta([[local <var> = require("<mod>")]], {
      var = d(2, require_var, { 1 }),
      mod = i(1),
    }),
  },
}
