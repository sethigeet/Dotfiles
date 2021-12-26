local LanguageServer = require("lsp.language_server")

local ls = LanguageServer:create({
  server_name = "vimls",
})

return ls
