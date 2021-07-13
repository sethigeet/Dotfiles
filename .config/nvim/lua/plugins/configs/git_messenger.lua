local plugin = {}

function plugin.setup()
  vim.g.git_messenger_no_default_mappings = Opts.plugin.git_messenger.config.no_default_mappings
end

function plugin.config()
  Opts.plugin["git_messenger"] = {
    enabled = true,
    config = {
      no_default_mappings = 1,
    },
  }
end

return plugin
