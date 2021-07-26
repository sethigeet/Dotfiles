local plugin = {}

function plugin.setup()
  vim.g.vsnip_filetypes = {
    javascriptreact = { "javascript" },
    typescriptreact = { "typescript" },
  }
  vim.g.vsnip_snippet_dir = CONFIG_PATH .. "/snippets"
end

return plugin
