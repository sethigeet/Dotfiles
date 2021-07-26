local plugin = {}

function plugin.setup()
  -- Replace netrw with vifm
  vim.g.vifm_replace_netrw = true

  -- Disable netrw since it is no longer being used
  vim.g.loaded_netrw = false
  vim.g.loaded_netrwPlugin = true
end

return plugin
