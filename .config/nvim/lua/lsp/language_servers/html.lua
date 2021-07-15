-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local LanguageServer = require("lsp.helpers.create_language_server")

local ls = LanguageServer:create({
  lang = "html",
  custom = {
    capabilities = capabilities,
  },
})

ls:setup()
