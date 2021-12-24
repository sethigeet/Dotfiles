-- Setup null-ls with custom lsp wrapper
local LanguageServer = require("lsp.helpers.language_server")

local ls = LanguageServer:create({
  server_name = "null-ls",
})

return ls
