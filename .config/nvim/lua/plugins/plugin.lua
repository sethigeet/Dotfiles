local Plugin = {
  configure = function() end,
  apply_integrations = function() end,

  augroups = {},
  keymaps = {},

  utils = {},
}

function Plugin:create(o)
  o = o or {} -- create object if user does not provide one
  setmetatable(o, self)
  self.__index = self

  return o
end

function Plugin:set_augroups()
  local augroups
  if type(self.augroups) == "function" then
    augroups = self:augroups()
  else
    augroups = self.augroups
  end

  if vim.tbl_isempty(augroups) then return end

  require("utils.wrappers").define_augroups(augroups)
end

function Plugin:set_keymaps()
  local modewise_keymaps
  if type(self.keymaps) == "function" then
    modewise_keymaps = self:keymaps()
  else
    modewise_keymaps = self.keymaps
  end

  if vim.tbl_isempty(modewise_keymaps) then return end

  local map = require("utils.wrappers").map
  for mode, keymaps in pairs(modewise_keymaps) do
    for _, keymap in ipairs(keymaps) do
      map(mode, keymap[1], keymap[2], keymap[3])
    end
  end
end

function Plugin:setup()
  self:apply_integrations()
  self:configure()
  self:set_augroups()
  self:set_keymaps()
end

return Plugin
