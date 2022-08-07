local Hydra = require("hydra")
local ts_swap = require("nvim-treesitter.textobjects.swap")

local swap_next = function(name)
  return function()
    ts_swap.swap_next(name)
  end
end
local swap_prev = function(name)
  return function()
    ts_swap.swap_previous(name)
  end
end

--[[
                         ██▄                      易Swap
                          ▀██▄     _b_: Next block         _B_: Prev block
      ▄██                   ▀██▄   _c_: Next class         _C_: Prev class
    ▄██▀    ███████████████████  _f_: Next function      _F_: Prev function
  ▄██▀                      ▄██▀   _i_: Next conditional   _I_: Prev conditional
 ███████████████████    ▄██▀     _l_: Next loop          _L_: Prev loop
  ▀██▄                   ██▀       _p_: Next parameter     _P_: Prev parameter
    ▀██▄
      ▀██      ^                                    _<Esc>_
]]

local menu = Hydra({
  name = "Swap",
  hint = [[
  ^ ^              易Swap
  _b_: Next block         _B_: Prev block
  _c_: Next class         _C_: Prev class
  _f_: Next function      _F_: Prev function
  _i_: Next conditional   _I_: Prev conditional  
  _l_: Next loop          _L_: Prev loop
  _p_: Next parameter     _P_: Prev parameter
 
  ^ ^              _<Esc>_
]] ,
  config = {
    color = "pink",
    hint = {
      border = "rounded",
      position = "bottom-right",
    },
  },
  mode = { "n" },
  heads = {
    { "b", swap_next("@block.outer") },
    { "B", swap_prev("@block.outer") },
    { "c", swap_next("@class.outer") },
    { "C", swap_prev("@class.outer") },
    { "f", swap_next("@function.outer") },
    { "F", swap_prev("@function.outer") },
    { "i", swap_next("@conditional.outer") },
    { "I", swap_prev("@conditional.outer") },
    { "l", swap_next("@loop.outer") },
    { "L", swap_prev("@loop.outer") },
    { "p", swap_next("@parameter.inner") },
    { "P", swap_prev("@parameter.inner") },
    { "<Esc>", nil, { exit = true } },
  },
})

return {
  init = function() end,

  menu = function()
    menu:activate()
  end,
}
