local LanguageServer = require("lsp.helpers.create_language_server")

local ls = LanguageServer:create({
  lang = "typescript",
  formatters = "prettier",
  linters = "eslint",
  on_attach = function(client, _)
    -- Disable formatting in the lsp server as `null-ls` handles formatting
    client.resolved_capabilities.document_formatting = false
  end,
})

return ls
