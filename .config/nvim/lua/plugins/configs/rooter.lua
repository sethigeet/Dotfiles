local plugin = {}

function plugin.setup()
  require("lsp-rooter").setup(Opts.plugin.rooter.config)
end

function plugin.config()
  Opts.plugin["rooter"] = {
    enabled = true,
    config = {
      -- Table of lsp clients to ignore by name
      -- eg: {"efm", ...}
      ignore_lsp = { "efm" },
    },
  }
end

return plugin
