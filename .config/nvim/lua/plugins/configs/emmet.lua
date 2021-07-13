local plugin = {}

function plugin.setup()
  vim.g.user_emmet_leader_key = Opts.plugin.emmet.config.leader_key
end

function plugin.config()
  Opts.plugin["emmet"] = {
    enabled = true,
    config = {
      leader_key = "<M-e>",
    },
  }
end

return plugin
