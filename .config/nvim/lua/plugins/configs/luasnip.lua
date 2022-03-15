local Plugin = require("plugins.plugin")

local function make_snips(snips, ls)
  local result = {}
  for trig, exp in pairs(snips) do
    local expansion
    if type(exp) == "string" then
      expansion = { ls.text_node({ exp }), ls.insert_node(0) }
    elseif type(exp) == "table" then
      for k, v in ipairs(exp) do
        if type(v) == "string" then
          exp[k] = ls.text_node({ v })
        end
      end
      expansion = exp
    end

    table.insert(result, ls.s({ trig = trig, desc = exp.desc }, expansion))
  end

  return result
end

return Plugin:create({
  configure = function()
    local luasnip = require("luasnip")

    luasnip.config.set_config({
      history = true,
      -- Update more often, :h events for more info.
      updateevents = "TextChanged,TextChangedI",
    })

    -- Load snippets from plugins
    require("luasnip/loaders/from_vscode").lazy_load()

    -- Load custom snippets
    for _, file in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
      local name = vim.fn.fnamemodify(file, ":t:r")
      local contents = require("snippets." .. name)

      local fts, snips = contents["filetypes"], contents["snippets"]
      if type(fts) == "table" then
        for _, ft in ipairs(fts) do
          luasnip.snippets[ft] = luasnip.snippets[ft] or {}
          for _, snip in ipairs(make_snips(snips, luasnip)) do
            table.insert(luasnip.snippets[ft], snip)
          end
        end
      elseif type(fts) == "string" then
        luasnip.snippets[fts] = luasnip.snippets[fts] or {}
        for _, snip in ipairs(make_snips(snips, luasnip)) do
          table.insert(luasnip.snippets[fts], snip)
        end
      end
    end
  end,
})
