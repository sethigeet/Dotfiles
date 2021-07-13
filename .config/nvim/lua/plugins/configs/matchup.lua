local plugin = {}

function plugin.setup()
  vim.g.matchup_matchparen_offscreen = Opts.plugin.matchup.config.matchparen_offscreen
end

function plugin.config()
  Opts.plugin["matchup"] = {
    enabled = true,
    config = {
      matchparen_offscreen = { method = "popup" },
    },
  }
end

return plugin
