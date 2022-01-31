local wrapper = {}

local function bootstrap()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  end

  vim.cmd("packadd packer.nvim")
end

local function change_plugin_config(plugin)
  if plugin.config and type(plugin.config) == "string" then
    plugin.config = 'require("plugins.configs.' .. plugin.config .. '"):setup()'
  end
end

local function process_plugins(plugins)
  for _, plugin in ipairs(plugins) do
    change_plugin_config(plugin)

    if plugin.requires then
      if type(plugin.requires) == "table" then
        if vim.tbl_islist(plugin.requires) then
          process_plugins(plugin.requires)
        else
          change_plugin_config(plugin.requires)
        end
      end
    end
  end
end

function wrapper.setup(config, plugins)
  bootstrap()

  local packer = require("packer")
  packer.init(config)

  process_plugins(plugins)

  return packer.startup({
    function(use)
      for _, plugin in ipairs(plugins) do
        use(plugin)
      end
    end,
  })
end

return wrapper
