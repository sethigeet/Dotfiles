local plugin = {}

function plugin.setup()
  if Opts.plugin.vifm.config.replace_netrw then
    -- Replace netrw with vifm
    vim.g.vifm_replace_netrw = 1

    -- Disable netrw since it is no longer being used
    vim.g.loaded_netrw = 0
    vim.g.loaded_netrwPlugin = 0
  end
end

function plugin.config()
  Opts.plugin["vifm"] = {
    enabled = true,
    config = {
      replace_netrw = true,
    },
  }
end

return plugin
