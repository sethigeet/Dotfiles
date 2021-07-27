local plugin = {}

function plugin.setup()
  require("lsp-rooter").setup({
    -- Table of lsp clients to ignore by name
    ignore_lsp = { "null-ls" },
  })
end

return plugin
