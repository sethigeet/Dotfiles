local LanguageServer = require("lsp.helpers.create_language_server")

local ls = LanguageServer:create({
  lang = "css",
  formatters = "prettier",
})

return ls
