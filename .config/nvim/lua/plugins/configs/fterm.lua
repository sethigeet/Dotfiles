local plugin = {}

function plugin.setup()
  local FTerm = require("FTerm")

  FTerm.setup({
    dimensions = { height = 0.8, width = 0.8, x = 0.5, y = 0.5 },
    border = "rounded",
  })

  local term = require("FTerm.terminal")

  local dropdown = term:new():setup({ dimensions = { height = 0.4, width = 0.9, y = 0 } })
  local lazygit = term:new():setup({ cmd = "lazygit", dimensions = { height = 0.8, width = 0.8 } })
  local node = term:new():setup({ cmd = "node", dimensions = { height = 0.8, width = 0.8 } })
  local python = term:new():setup({ cmd = "python", dimensions = { height = 0.8, width = 0.8 } })

  function TermToggle(type)
    local terminals = {
      dropdown = function()
        dropdown:toggle()
      end,
      lazygit = function()
        lazygit:toggle()
      end,
      node = function()
        node:toggle()
      end,
      python = function()
        python:toggle()
      end,
    }

    if terminals[type] ~= nil then
      terminals[type]()
    else
      FTerm.toggle()
    end
  end

  plugin.keymaps()
end

function plugin.keymaps()
  local map = require("utils.map")

  map.nnoremap("<F1>", require("FTerm").toggle)
  map.tnoremap("t", "<F1>", require("FTerm").toggle)
end

return plugin
