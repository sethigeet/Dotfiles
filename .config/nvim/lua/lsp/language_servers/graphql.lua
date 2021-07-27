local LanguageServer = require("lsp.helpers.create_language_server")

local ls = LanguageServer:create({
  lang = "graphql",
  formatters = "prettier",
})

return ls
