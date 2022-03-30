-- Setup null-ls with custom lsp wrapper
local LanguageServer = require("lsp.language_server")

local ls = LanguageServer:create({
  server_name = "null-ls",

  virtual_text = {
    inlay_hints = false,
    code_lens = false,
    dim_unused = false,
  },
})

return ls
