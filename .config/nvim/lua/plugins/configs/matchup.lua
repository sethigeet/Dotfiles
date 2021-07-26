local plugin = {}

function plugin.setup()
  vim.g.matchup_matchparen_offscreen = { method = "popup" }
end

return plugin
