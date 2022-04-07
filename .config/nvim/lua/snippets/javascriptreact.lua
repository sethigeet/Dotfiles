local ls = require("luasnip")
local sn = ls.sn
local i = ls.insert_node
local t = ls.text_node
local d = ls.dynamic_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

local set_state_setter = function(args, _)
  local text = args[1][1] or ""
  local setter_name = string.upper(string.sub(text, 1, 1) or "") .. (string.sub(text, 2) or "")

  return sn(nil, {
    c(1, { t({ setter_name }), t({ "" }) }),
  })
end

return {
  filetypes = { "javascriptreact", "typescriptreact" },
  snippets = {
    useState = fmt([[const [{}, set{}] = useState({})]], {
      i(1),
      d(2, set_state_setter, { 1 }),
      i(3),
    }),
  },
}
