local LanguageServer = require("lsp.helpers.create_language_server")

local ls = LanguageServer:create({
  lang = "python",
  custom = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
        },
      },
    },
  },
})

ls:setup()
