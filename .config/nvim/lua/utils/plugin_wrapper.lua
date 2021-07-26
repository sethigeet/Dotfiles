local wrapper = {}

function wrapper.bootstrap()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
  end

  vim.cmd("packadd packer.nvim")
end

function wrapper.setup(config, plugins)
  wrapper.bootstrap()

  local packer = require("packer")
  packer.init(config)

  return packer.startup({
    function(use)
      for _, plugin in ipairs(plugins) do
        if plugin.config and type(plugin.config) == "string" then
          plugin.config = 'require("plugins.configs.' .. plugin.config .. '").setup()'
        end

        use(plugin)
      end
    end,
  })
end

return wrapper
