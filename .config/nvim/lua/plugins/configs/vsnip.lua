local plugin = {}

function plugin.setup()
  vim.g.vsnip_filetypes = Opts.plugin.vsnip.config.filetypes
  vim.g.vsnip_snippet_dir = Opts.plugin.vsnip.config.snippets_dir
end

function plugin.config()
  Opts.plugin["vsnip"] = {
    enabled = true,
    config = {
      filetypes = {
        javascriptreact = { "javascript" },
        typescriptreact = { "typescript" },
      },
      snippets_dir = CONFIG_PATH .. "/snippets",
    },
  }
end

return plugin
