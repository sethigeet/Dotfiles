local LanguageServer = require("lsp.language_server")

local ls = LanguageServer:create({
  server_name = "taplo",
  cmd_args = { "--default-schema-catalogs" },
})

return ls
