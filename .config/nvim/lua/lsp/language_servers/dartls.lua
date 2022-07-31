local LanguageServer = require("lsp.language_server")

local ls = LanguageServer:create({
  server_name = "dartls",

  virtual_text = {
    inlay_hints = true,
    code_lens = true,
  },
})

return ls
