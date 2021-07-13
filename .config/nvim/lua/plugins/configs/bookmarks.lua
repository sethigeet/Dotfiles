local plugin = {}

function plugin.setup()
  vim.g.bookmark_no_default_key_mappings = Opts.plugin.bookmarks.config.no_default_key_mappings and 1 or 0
  vim.g.bookmark_sign = Opts.plugin.bookmarks.config.sign
end

function plugin.config()
  Opts.plugin["bookmarks"] = {
    enabled = true,
    config = {
      no_default_key_mappings = true,
      sign = "",
    },
  }
end

return plugin
