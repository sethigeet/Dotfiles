local ls = require("luasnip")
local sn = ls.sn
local i = ls.insert_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local f = ls.function_node
local rep = require("luasnip.extras").rep

-- Get a list of  the property names given an `interface_declaration`
-- treesitter *tsx* node.
-- Ie, if the treesitter node represents:
--   interface {
--     prop1: string;
--     prop2: number;
--   }
-- Then this function would return `{"prop1", "prop2"}
---@param id_node {} Stands for "interface declaration node"
---@return string[]
local function get_prop_names(id_node)
  local object_type_node = id_node:child(2)
  if object_type_node:type() ~= "object_type" then
    return {}
  end

  local prop_names = {}

  for prop_signature in object_type_node:iter_children() do
    if prop_signature:type() == "property_signature" then
      local prop_iden = prop_signature:child(0)
      local prop_name = vim.treesitter.query.get_node_text(prop_iden, 0)
      prop_names[#prop_names + 1] = prop_name
    end
  end

  return prop_names
end

return {
  filetypes = { "typescriptreact" },
  snippets = {
    comp = fmt(
      [[
import {{ FC }} from  "react";

interface {}Props {{
  {}
}}

export const {}: FC<{}Props> = ({{ {} }}) => {{
  return (
    <div>
      {}
    </div>
  )
}}
]]     ,
      {
        -- Initialize component name to file name
        d(1, function(_, snip)
          return sn(nil, {
            i(1, vim.fn.substitute(snip.env.TM_FILENAME, "\\..*$", "", "g")),
          })
        end),
        i(2, "// props"),
        rep(1),
        rep(1),
        f(function(_, snip)
          if not snip.nodes[6].mark then
            return ""
          end

          local pos_begin = snip.nodes[6].mark:pos_begin()
          local pos_end = snip.nodes[6].mark:pos_end()
          local parser = vim.treesitter.get_parser(0, "tsx", nil)
          local tstree = parser:parse()

          local node = tstree[1]:root():named_descendant_for_range(pos_begin[1], pos_begin[2], pos_end[1], pos_end[2])

          while node ~= nil and node:type() ~= "interface_declaration" do
            node = node:parent()
          end

          if node == nil then
            return ""
          end

          local prop_names = get_prop_names(node)
          return vim.fn.join(prop_names, ", ")
        end),
        i(5, ""),
      }
    ),
  },
}
