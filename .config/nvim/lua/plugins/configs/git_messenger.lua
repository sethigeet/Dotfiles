local plugin = {}

function plugin.setup()
  vim.g.git_messenger_no_default_mappings = 1
end

return plugin
