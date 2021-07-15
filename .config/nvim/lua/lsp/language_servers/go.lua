local LanguageServer = require("lsp.helpers.create_language_server")

local ls = LanguageServer:create({
  lang = "go",
  custom = {
    settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
    init_options = { usePlaceholders = true },
  },
})

ls:setup()
