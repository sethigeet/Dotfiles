-- Configure null-ls
require("null-ls").config({})

-- Setup null-ls with custom lsp wrapper
local LanguageServer = require("lsp.helpers.create_language_server")

local ls = LanguageServer:create({
  lang = "null-ls",
})

return ls
