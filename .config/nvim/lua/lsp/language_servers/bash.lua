local LanguageServer = require("lsp.helpers.create_language_server")

local ls = LanguageServer:create({
  lang = "bash",
  filetypes = { "sh", "bash", "zsh" },
})

ls:setup()
