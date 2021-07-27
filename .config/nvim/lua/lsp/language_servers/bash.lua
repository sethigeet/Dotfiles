local LanguageServer = require("lsp.helpers.create_language_server")

local ls = LanguageServer:create({
  lang = "bash",
  filetypes = { "sh", "bash", "zsh" },
  formatters = "shfmt",
  linters = "shellcheck"
})

ls:setup()
