local LanguageServer = require("lsp.helpers.language_server")

local ls = LanguageServer:create({
  server_name = "html",
  formatters = "prettierd",
})

return ls
